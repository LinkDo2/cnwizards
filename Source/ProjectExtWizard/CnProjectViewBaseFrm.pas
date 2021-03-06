{******************************************************************************}
{                       CnPack For Delphi/C++Builder                           }
{                     中国人自己的开放源码第三方开发包                         }
{                   (C)Copyright 2001-2018 CnPack 开发组                       }
{                   ------------------------------------                       }
{                                                                              }
{            本开发包是开源的自由软件，您可以遵照 CnPack 的发布协议来修        }
{        改和重新发布这一程序。                                                }
{                                                                              }
{            发布这一开发包的目的是希望它有用，但没有任何担保。甚至没有        }
{        适合特定目的而隐含的担保。更详细的情况请参阅 CnPack 发布协议。        }
{                                                                              }
{            您应该已经和开发包一起收到一份 CnPack 发布协议的副本。如果        }
{        还没有，可访问我们的网站：                                            }
{                                                                              }
{            网站地址：http://www.cnpack.org                                   }
{            电子邮件：master@cnpack.org                                       }
{                                                                              }
{******************************************************************************}

unit CnProjectViewBaseFrm;
{ |<PRE>
================================================================================
* 软件名称：CnPack IDE 专家包
* 单元名称：工程扩展工具窗体列表单元列表基类
* 单元作者：Leeon (real-like@163.com); 张伟（Alan） BeyondStudio@163.com
* 备    注：
* 开发平台：PWin2000Pro + Delphi 5.5
* 兼容测试：PWin2000 + Delphi 5/6/7
* 本 地 化：该窗体中的字符串支持本地化处理方式
* 单元标识：$Id$
* 修改记录：2004.02.22 V1.1
*               重写所有代码
*           2004.02.08 V1.0
*               创建单元
================================================================================
|</PRE>}

interface

{$I CnWizards.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 
  ImgList, Contnrs, ActnList, 
{$IFDEF COMPILER6_UP}
  StrUtils,
{$ENDIF COMPILER6_UP}
  ComCtrls, StdCtrls, ExtCtrls, Math, ToolWin, Clipbrd, IniFiles, ToolsAPI,
  CnCommon, CnConsts, CnWizConsts, CnWizOptions, CnWizUtils, CnIni, CnWizIdeUtils,
  CnWizMultiLang, CnWizShareImages, CnWizNotifier, CnIniStrUtils, RegExpr,
  CnStrings;

type

//==============================================================================
// 工程信息类
//==============================================================================

{ TCnProjectInfo }

  TCnProjectInfo = class
    Name: string;
    FileName: string;
  end;

//==============================================================================
// 列表信息基类
//==============================================================================

  TCnBaseElementInfo = class
  private
    FText: string;
    FMatchIndexes: TList;
    FParentProject: TCnProjectInfo;
  public
    constructor Create;
    destructor Destroy; override;

    property MatchIndexes: TList read FMatchIndexes;
    {* 模糊匹配 Text 的下标}
    property ParentProject: TCnProjectInfo read FParentProject write FParentProject;
    {* 该元素从属的 Project，无则为 nil}
  published
    property Text: string read FText write FText;
    {* Text 表示第一列显示的文字}
  end;

//==============================================================================
// 工程组单元窗体列表基类窗体
//==============================================================================

{ TCnProjectViewBaseForm }

  TCnProjectViewBaseForm = class(TCnTranslateForm)
    actAttribute: TAction;
    actClose: TAction;
    actCopy: TAction;
    actHelp: TAction;
    actHookIDE: TAction;
    ActionList: TActionList;
    actMatchAny: TAction;
    actMatchStart: TAction;
    actOpen: TAction;
    actQuery: TAction;
    actSelectAll: TAction;
    actSelectInvert: TAction;
    actSelectNone: TAction;
    cbbProjectList: TComboBox;
    edtMatchSearch: TEdit;
    lblProject: TLabel;
    lblSearch: TLabel;
    lvList: TListView;
    pnlHeader: TPanel;
    StatusBar: TStatusBar;
    btnMatchAny: TToolButton;
    btnAttribute: TToolButton;
    btnClose: TToolButton;
    btnCopy: TToolButton;
    btnHelp: TToolButton;
    btnHookIDE: TToolButton;
    btnOpen: TToolButton;
    btnQuery: TToolButton;
    btnSelectInvert: TToolButton;
    btnSelectAll: TToolButton;
    btnSep1: TToolButton;
    btnSep3: TToolButton;
    btnSep4: TToolButton;
    btnSep5: TToolButton;
    btnSep6: TToolButton;
    btnSep7: TToolButton;
    btnSep8: TToolButton;
    btnMatchStart: TToolButton;
    btnSelectNone: TToolButton;
    ToolBar: TToolBar;
    actFont: TAction;
    btnFont: TToolButton;
    dlgFont: TFontDialog;
    btnMatchFuzzy: TToolButton;
    actMatchFuzzy: TAction;
    procedure lvListDblClick(Sender: TObject);
    procedure edtMatchSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvListColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbbProjectListChange(Sender: TObject);
    procedure edtMatchSearchChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvListCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure actSelectAllExecute(Sender: TObject);
    procedure actSelectNoneExecute(Sender: TObject);
    procedure actSelectInvertExecute(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actFontExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actAttributeExecute(Sender: TObject);
    procedure actMatchStartExecute(Sender: TObject);
    procedure actMatchAnyExecute(Sender: TObject);
    procedure actQueryExecute(Sender: TObject);
    procedure lvListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure actHookIDEExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvListKeyPress(Sender: TObject; var Key: Char);
    procedure lvListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actMatchFuzzyExecute(Sender: TObject);
  private
    FSortIndex: Integer;
    FSortDown: Boolean;
    FListViewWidthStr: string;
    FProjectListSelectedAllProject: Boolean;
    function GetMatchAny: Boolean;
    procedure SetMatchAny(const Value: Boolean);

    procedure FirstUpdate(Sender: TObject);
    function GetMatchMode: TCnMatchMode;
    procedure SetMatchMode(const Value: TCnMatchMode);
    procedure PrepareProjectRange;
  protected
    FRegExpr: TRegExpr;
    NeedInitProjectControls: Boolean;
    ProjectList: TObjectList;     // 存储 ProjectInfo 的列表
    ProjectInfo: TCnProjectInfo;  // 标记待限定的 Project 搜索范围
    DataList: TStringList;        // 供子类存储原始需要搜索的列表名字以及 Object
    DisplayList: TStringList;     // 供子类容纳过滤后需要显示的列表名字以及 Object（引用）
    // CurrList: TList;
    function DoSelectOpenedItem: string; virtual; abstract;
    procedure DoSelectItemChanged(Sender: TObject); virtual;
    procedure DoUpdateListView; virtual;

    // === New Routines for refactor ===
    // 实现根据匹配规则从 DataList 更新至 DisplayList的功能，一般无须重载
    procedure CommonUpdateListView; virtual;
    // 子类重载以返回在指定匹配字符、指定匹配模式下，DataList 中的指定项是否匹配
    // 调用此方法前 ProjectInfo 指定了下拉框所标识的工程范围
    function CanMatchDataByIndex(const AMatchStr: string; AMatchMode: TCnMatchMode;
      DataListIndex: Integer): Boolean; virtual;
    // 子类重载以返回此项是否可以作为优先选中的项，一般无须重载
    function CanSelectDataByIndex(const AMatchStr: string; AMatchMode: TCnMatchMode;
      DataListIndex: Integer): Boolean; virtual;
    // 排序比较器，子类重载以实现根据 Object 比较的功能
    function SortItemCompare(ASortIndex: Integer; const AMatchStr: string;
      const S1, S2: string; Obj1, Obj2: TObject): Integer; virtual;

    // 默认匹配的实现，只匹配 DataList 中的字符串，不处理其 Object 所代表的内容
    function DefaultMatchHandler(const AMatchStr: string; AMatchMode: TCnMatchMode;
      DataListIndex: Integer): Boolean;
    // 默认允许优先选择最头上匹配的项
    function DefaultSelectHandler(const AMatchStr: string; AMatchMode: TCnMatchMode;
      DataListIndex: Integer): Boolean;
    // 释放 DataList 供重新初始化的场合
    procedure ClearDataList;
    // === New Routines for refactor ===

    procedure DoSortListView; virtual;
    {* 供子类重载用，被 UpdateListView 调用}
    function GetSelectedFileName: string; virtual; abstract;
    procedure CreateList; virtual;
    {* 窗体 OnCreate 时被第一个调用，用来初始化数据，一般把内容加载进 DataList 中，
       如果待加载内容太多，也可在 UpdateListView 时做 }
    procedure UpdateComboBox; virtual;
    {* 窗体 OnCreate 时被第二个调用，用来初始化 ComboBox 中的内容}
    procedure UpdateListView; virtual;
    {* 窗体 OnCreate 时被第三个调用，用来更新 ListView 中的内容，同时还在其他响应输入的地方调用}
    procedure UpdateStatusBar; virtual;
    procedure OpenSelect; virtual; abstract;
    procedure FontChanged(AFont: TFont); virtual;
    procedure DrawListItem(ListView: TCustomListView; Item: TListItem); virtual; abstract;
    procedure SelectFirstItem;
    procedure SelectItemByIndex(AIndex: Integer);
    procedure LoadProjectSettings(Ini: TCustomIniFile; aSection: string);
    procedure SaveProjectSettings(Ini: TCustomIniFile; aSection: string);
  public
    procedure SelectOpenedItem;
    procedure LoadSettings(Ini: TCustomIniFile; aSection: string); virtual;
    procedure SaveSettings(Ini: TCustomIniFile; aSection: string); virtual;
    property SortIndex: Integer read FSortIndex write FSortIndex;
    property SortDown: Boolean read FSortDown write FSortDown;
    property MatchMode: TCnMatchMode read GetMatchMode write SetMatchMode;
    property MatchAny: Boolean read GetMatchAny write SetMatchAny;
  end;

implementation

{$R *.DFM}

{$IFDEF DEBUG}
uses
  CnDebug;
{$ENDIF}

const
  csMatchAny = 'MatchAny';
  csMatchMode = 'MatchMode';
  csFont = 'Font';
  csSortIndex = 'SortIndex';
  csSortDown = 'SortDown';
  csCurrentPrj = 'SelectCurrentProject';
  csHookIDE = 'HookIDE';
  csOpenMultiUnitQuery = 'Query';
  csWidth = 'Width';
  csHeight = 'Height';
  csListViewWidth = 'ListViewWidth';

type
  TSortCompareEvent = function(ASortIndex: Integer; const AMatchStr: string;
    const S1, S2: string; Obj1, Obj2: TObject): Integer of object;

var
  GlobalSortIndex: Integer;
  GlobalSortDown: Boolean;
  GlobalSortMatchStr: string;
  GlobalSortCompareEvent: TSortCompareEvent = nil;

function DoListSort(List: TStringList; Index1, Index2: Integer): Integer;
var
  Obj1, Obj2: TObject;
begin
  Obj1 := List.Objects[Index1];
  Obj2 := List.Objects[Index2];

  if Assigned(GlobalSortCompareEvent) then
  begin
    Result := GlobalSortCompareEvent(GlobalSortIndex, GlobalSortMatchStr,
      List[Index1], List[Index2], Obj1, Obj2);
    if GlobalSortDown then
      Result := -Result;
  end
  else
    Result := AnsiCompareStr(List[Index1], List[Index2]);
end;

//==============================================================================
// 工程组单元窗体列表基类窗体
//==============================================================================

{ TCnProjectViewBaseForm }

procedure TCnProjectViewBaseForm.FormCreate(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    FRegExpr := TRegExpr.Create;
    FRegExpr.ModifierI := True;

    lvList.DoubleBuffered := True;
    ProjectList := TObjectList.Create;
    //CurrList := TList.Create;
    NeedInitProjectControls := True;

    DataList := TStringList.Create;
    DisplayList := TStringList.Create;
    GlobalSortCompareEvent := SortItemCompare;

    CreateList;
    UpdateComboBox;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TCnProjectViewBaseForm.FormShow(Sender: TObject);
begin
  UpdateListView;
  SelectOpenedItem;
{$IFDEF BDS}
  SetListViewWidthString(lvList, FListViewWidthStr);
{$ENDIF}
  CnWizNotifierServices.ExecuteOnApplicationIdle(FirstUpdate);
end;

procedure TCnProjectViewBaseForm.FormDestroy(Sender: TObject);
begin
  CnWizNotifierServices.StopExecuteOnApplicationIdle(DoSelectItemChanged);
  ProjectList.Free;
  GlobalSortCompareEvent := nil;
  ClearDataList;
  FreeAndNil(DataList);
  FreeAndNil(DisplayList);
  //CurrList.Free;
  FRegExpr.Free;
end;

procedure TCnProjectViewBaseForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    lvListDblClick(Sender);
    Key := #0;
  end
  else if Key = #27 then
  begin
    ModalResult := mrCancel;
    Key := #0;
  end
  else if Key = #22 then // Ctrl + V
  begin
    if edtMatchSearch.Focused then
    begin
      if Clipboard.HasFormat(CF_TEXT) then
      begin
        edtMatchSearch.PasteFromClipboard;
        edtMatchSearch.Text := Trim(edtMatchSearch.Text);
        Key := #0;
      end;
    end;
  end;
end;

procedure TCnProjectViewBaseForm.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  actSelectAll.Enabled := lvList.Items.Count > 0;
  actSelectNone.Enabled := lvList.Items.Count > 0;
  actSelectInvert.Enabled := lvList.Items.Count > 0;

  actOpen.Enabled := lvList.SelCount > 0;
  actAttribute.Enabled := lvList.SelCount > 0;
  actCopy.Enabled := lvList.SelCount > 0;

  Handled := True;
end;

procedure TCnProjectViewBaseForm.actCopyExecute(Sender: TObject);
var
  i: Integer;
  AList: TStringList;
begin
  AList := TStringList.Create;
  try
    with lvList do
    begin
      for i := 0 to Pred(Items.Count) do
        if Items.Item[i].Selected and (Items.Item[i].Caption <> '') then
          AList.Add(Items[i].Caption);
    end;
  finally
    if AList.Count > 0 then
      Clipboard.AsText := TrimRight(AList.Text);
    FreeAndNil(AList);
  end;
end;

procedure TCnProjectViewBaseForm.actSelectAllExecute(Sender: TObject);
var
  i: Integer;
begin
  with lvList do
    for i := 0 to Pred(Items.Count) do
      Items[i].Selected := True;
end;

procedure TCnProjectViewBaseForm.actSelectNoneExecute(Sender: TObject);
begin
  lvList.Selected := nil;
end;

procedure TCnProjectViewBaseForm.actSelectInvertExecute(Sender: TObject);
var
  i: Integer;
begin
  with lvList do
    for i := Pred(Items.Count) downto 0 do
      Items[i].Selected := not Items[i].Selected;
end;

procedure TCnProjectViewBaseForm.actAttributeExecute(Sender: TObject);
var
  FileName: string;
begin
  FileName := GetSelectedFileName;

  if FileExists(FileName) then
    FileProperties(FileName)
  else
    InfoDlg(SCnProjExtFileNotExistOrNotSave, SCnInformation, 64);
end;

procedure TCnProjectViewBaseForm.actOpenExecute(Sender: TObject);
begin
  OpenSelect;
end;

procedure TCnProjectViewBaseForm.actHookIDEExecute(Sender: TObject);
begin
  actHookIDE.Checked := not actHookIDE.Checked;
end;

procedure TCnProjectViewBaseForm.actMatchStartExecute(Sender: TObject);
begin
  MatchAny := False;
  MatchMode := mmStart;
  UpdateListView;
end;

procedure TCnProjectViewBaseForm.actMatchAnyExecute(Sender: TObject);
begin
  MatchAny := True;
  MatchMode := mmAnywhere;
  UpdateListView;
end;

procedure TCnProjectViewBaseForm.FontChanged(AFont: TFont);
begin

end;

procedure TCnProjectViewBaseForm.actFontExecute(Sender: TObject);
begin
  dlgFont.Font := lvList.Font; 
  if dlgFont.Execute then
  begin
    lvList.ParentFont := False;
    lvList.Font := dlgFont.Font;
    FontChanged(dlgFont.Font);
  end;
end;

procedure TCnProjectViewBaseForm.actQueryExecute(Sender: TObject);
begin
  actQuery.Checked := not actQuery.Checked;
end;

procedure TCnProjectViewBaseForm.actCloseExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TCnProjectViewBaseForm.edtMatchSearchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if not (((Key = VK_F4) and (ssAlt in Shift)) or
    (Key in [VK_DELETE, VK_LEFT, VK_RIGHT]) or
    ((Key in [VK_HOME, VK_END]) and not (ssCtrl in Shift)) or
    ((Key in [VK_INSERT]) and ((ssShift in Shift) or (ssCtrl in Shift)))) then
  begin
    SendMessage(lvList.Handle, WM_KEYDOWN, Key, 0);
    Key := 0;
  end;
end;

procedure TCnProjectViewBaseForm.actHelpExecute(Sender: TObject);
begin
  ShowFormHelp;
end;

function TCnProjectViewBaseForm.GetMatchAny: Boolean;
begin
  Result := actMatchAny.Checked;
end;

procedure TCnProjectViewBaseForm.SetMatchAny(const Value: Boolean);
begin
  actMatchAny.Checked := Value;
  actMatchStart.Checked := not Value;
end;

procedure TCnProjectViewBaseForm.DoSortListView;
var
  Sel: Pointer;
begin
  if lvList.Selected <> nil then
    Sel := lvList.Selected.Data
  else
    Sel := nil;

  GlobalSortIndex := SortIndex;
  GlobalSortDown := SortDown;
  GlobalSortMatchStr := edtMatchSearch.Text;

  QuickSortStringList(DisplayList, 0, DisplayList.Count - 1, DoListSort);
  lvList.Invalidate;

  if Sel <> nil then
    SelectItemByIndex(DisplayList.IndexOfObject(Sel));
end;

procedure TCnProjectViewBaseForm.lvListColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if FSortIndex = Column.Index then
    FSortDown := not FSortDown
  else
    FSortIndex := Column.Index;
  DoSortListView;
end;

procedure TCnProjectViewBaseForm.lvListDblClick(Sender: TObject);
begin
  OpenSelect;
end;

procedure TCnProjectViewBaseForm.cbbProjectListChange(Sender: TObject);
begin
  if Sender is TComboBox then
  begin
    if TComboBox(Sender).ItemIndex = cbbProjectList.Items.IndexOf(SCnProjExtCurrentProject) then
    begin
      FProjectListSelectedAllProject := False;
    end
    else if TComboBox(Sender).ItemIndex = cbbProjectList.Items.IndexOf(SCnProjExtProjectAll) then
    begin
      FProjectListSelectedAllProject := True;
    end;
  end;
  if Visible then
  begin
    UpdateListView;
    SelectOpenedItem;
  end;
end;

procedure TCnProjectViewBaseForm.LoadProjectSettings(Ini: TCustomIniFile;
  aSection: string);
begin
  with Ini do
  begin
    FProjectListSelectedAllProject := not ReadBool(aSection, csCurrentPrj, False);
    if not FProjectListSelectedAllProject then
    begin
      cbbProjectList.ItemIndex := cbbProjectList.Items.IndexOf(SCnProjExtCurrentProject);
      cbbProjectListChange(nil);
    end
    else
      cbbProjectList.ItemIndex := cbbProjectList.Items.IndexOf(SCnProjExtProjectAll);

    actHookIDE.Checked := ReadBool(aSection, csHookIDE, True);
    actQuery.Checked := ReadBool(aSection, csOpenMultiUnitQuery, True);
  end;
end;

procedure TCnProjectViewBaseForm.SaveProjectSettings(Ini: TCustomIniFile;
  aSection: string);
begin
  with Ini do
  begin
    if not FProjectListSelectedAllProject then
      WriteBool(aSection, csCurrentPrj, True)
    else
      WriteBool(aSection, csCurrentPrj, False);

    WriteBool(aSection, csHookIDE, actHookIDE.Checked);
    WriteBool(aSection, csOpenMultiUnitQuery, actQuery.Checked);
  end;
end;

procedure TCnProjectViewBaseForm.LoadSettings(Ini: TCustomIniFile; aSection: string);
var
  sFont: string;
begin
  with TCnIniFile.Create(Ini) do
  try
    MatchAny := ReadBool(aSection, csMatchAny, True);
    MatchMode := TCnMatchMode(ReadInteger(aSection, csMatchMode, Ord(mmFuzzy)));

    sFont := ReadString(aSection, csFont, '');
{$IFDEF DEBUG}
    CnDebugger.LogMsg('ReadFont: ' + sFont);
    CnDebugger.LogMsg('SelfFont: ' + FontToString(Self.Font));
{$ENDIF DEBUG}
    if (sFont <> '') and (sFont <> FontToString(Self.Font)) then
    begin
      // 只有保存的字体不等于窗体字体的时候，也即用户设置过字体后，才载入
      lvList.ParentFont := False;
      lvList.Font := ReadFont(aSection, csFont, lvList.Font);
      dlgFont.Font := lvList.Font;
      FontChanged(dlgFont.Font);
    end;

    FSortIndex := ReadInteger(aSection, csSortIndex, 0);
    FSortDown := ReadBool(aSection, csSortDown, False);
    lvList.CustomSort(nil, 0); // 按保存的设置排序

    Width := ReadInteger(aSection, csWidth, Width);
    Height := ReadInteger(aSection, csHeight, Height);
    CenterForm(Self);
    
    FListViewWidthStr := ReadString(aSection, csListViewWidth, '');
    SetListViewWidthString(lvList, FListViewWidthStr);
  finally
    Free;
  end;

  if NeedInitProjectControls then
    LoadProjectSettings(Ini, aSection);
end;

procedure TCnProjectViewBaseForm.SaveSettings(Ini: TCustomIniFile; aSection: string);
begin
  with TCnIniFile.Create(Ini) do
  try
    WriteBool(aSection, csMatchAny, MatchAny);
    WriteInteger(aSection, csMatchMode, Ord(MatchMode));
    WriteInteger(aSection, csSortIndex, FSortIndex);
    WriteBool(aSection, csSortDown, FSortDown);

    // 如用户没设置过字体，ParentFont 会为 True，无论语言如何切换总会跟随变化
    if not lvList.ParentFont then
      WriteFont(aSection, csFont, lvList.Font)
    else
      WriteString(aSection, csFont, '');

    WriteInteger(aSection, csWidth, Width);
    WriteInteger(aSection, csHeight, Height);
    WriteString(aSection, csListViewWidth, GetListViewWidthString(lvList));
  finally
    Free;
  end;

  if NeedInitProjectControls then
    SaveProjectSettings(Ini, aSection);
end;

procedure TCnProjectViewBaseForm.UpdateStatusBar;
begin

end;

procedure TCnProjectViewBaseForm.SelectFirstItem;
begin
  with lvList do
  begin
    Selected := nil;
    Selected := Items[0];
    ItemFocused := Selected;
  end;
end;

procedure TCnProjectViewBaseForm.SelectOpenedItem;
var
  i: Integer;
  aCurrentName: string;
begin
  with lvList do
  begin
    if Items.Count = 0 then
      Exit;

    aCurrentName := DoSelectOpenedItem;
    SelectFirstItem;

    if aCurrentName = '' then
      Exit;

    for i := 0 to Pred(Items.Count) do
      if AnsiSameText(Items[i].Caption, aCurrentName) then
      begin
        Selected := nil;
        Items[i].Selected := True;
        ItemFocused := Selected;
        Selected.MakeVisible(False);
        Break;
      end;
  end;
end;

procedure TCnProjectViewBaseForm.UpdateComboBox;
begin

end;

procedure TCnProjectViewBaseForm.CreateList;
begin

end;

procedure TCnProjectViewBaseForm.UpdateListView;
begin
  PrepareProjectRange;
  CommonUpdateListView;
  DoUpdateListView;
  // RemoveListViewSubImages(lvList);
end;

procedure TCnProjectViewBaseForm.DoSelectItemChanged(Sender: TObject);
begin
  UpdateStatusBar;
  StatusBar.Invalidate;
end;

procedure TCnProjectViewBaseForm.edtMatchSearchChange(Sender: TObject);
begin
  UpdateListView;
end;

procedure TCnProjectViewBaseForm.lvListCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  DrawListItem(Sender, Item);
end;

procedure TCnProjectViewBaseForm.lvListSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  CnWizNotifierServices.ExecuteOnApplicationIdle(DoSelectItemChanged);
end;

procedure TCnProjectViewBaseForm.SelectItemByIndex(AIndex: Integer);
begin
  if (AIndex >= 0) and (AIndex < lvList.Items.Count) then
  begin
    lvList.Selected := nil;
    lvList.Selected := lvList.Items[AIndex];
    lvList.ItemFocused := lvList.Selected;
  end;
end;

procedure TCnProjectViewBaseForm.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
const
  CNCOPY_SPLITER  = #9;     // TAB
  CNCOPY_LINE     = #13#10;
var
  I, J: Integer;
  CopyBuf: string;
begin
  if lvList.MultiSelect then
  begin
    if Shift = [ssCtrl] then
    begin
      // 选择全部
      if Key = Ord('A') then
      begin
        lvList.Items.BeginUpdate;
        try
          for I := 0 to lvList.Items.Count - 1 do
            lvList.Items[I].Selected := True;
        finally
          lvList.Items.EndUpdate;
        end;
        Key := 0;
      end
      // 取消选择
      else if Key = Ord('D') then
      begin
        lvList.Items.BeginUpdate;
        try
          for I := 0 to lvList.Items.Count - 1 do
            lvList.Items[I].Selected := False;
        finally
          lvList.Items.EndUpdate;
        end;
        Key := 0;
      end
      // 复制文本
      // 现为初步功能，复制所有文字，日后可实现可选列
      else if Key = Ord('C') then
      begin
        if edtMatchSearch.Focused and (edtMatchSearch.SelText <> '') then
          Exit; // 有选择时不进行额外的复制

        if lvList.Selected <> nil then
        begin
          CopyBuf := '';

          // 产生标题
          for I := 0 to lvList.Columns.Count - 1 do
          begin
            CopyBuf := CopyBuf + lvList.Column[I].Caption;
            if I < lvList.Columns.Count - 1 then
              CopyBuf := CopyBuf + CNCOPY_SPLITER;
          end;
          CopyBuf := CopyBuf + CNCOPY_LINE;

          // 复制内容
          for I := 0 to lvList.Items.Count - 1 do
          begin
            if lvList.Items[I].Selected then
            begin
              CopyBuf := CopyBuf + lvList.Items[I].Caption;
              for J := 0 to lvList.Items[I].SubItems.Count - 1 do
                CopyBuf := CopyBuf + CNCOPY_SPLITER + lvList.Items[I].SubItems[J];
              CopyBuf := CopyBuf + CNCOPY_LINE;
            end;
          end;

          // 放入剪贴板
          Clipboard.Clear;
          Clipboard.SetTextBuf(PChar(CopyBuf));
        end
        else
        begin
          // 这里可以增加提示没有选择需要复制的内容
        end;  // if lvList.Selected <> nil
      end;
    end;
  end;
end;

procedure TCnProjectViewBaseForm.lvListKeyPress(Sender: TObject;
  var Key: Char);
begin
  if CharInSet(Key, ['0'..'9', 'a'..'z', 'A'..'Z']) then
  begin
    PostMessage(edtMatchSearch.Handle, WM_CHAR, Integer(Key), 0);
    try
      edtMatchSearch.SetFocus;
    except
      ;
    end;
    Key := #0;
  end;
end;

procedure TCnProjectViewBaseForm.lvListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key in [VK_BACK] then
  begin
    //PostMessage(edtMatchSearch.Handle, WM_CHAR, Integer(Key), 0);
    try
      edtMatchSearch.SetFocus;
    except
      ;
    end;
  end;
end;

procedure TCnProjectViewBaseForm.FirstUpdate(Sender: TObject);
var
  I: Integer;
begin
  // Toolbar 的按钮在对应 Action 有隐藏的情况下可能会出现混乱，需要用这种办法修复一下
  for I := 0 to ActionList.ActionCount - 1 do
  begin
    if ActionList.Actions[I] is TAction then
    begin
      if not (ActionList.Actions[I] as TAction).Visible then
      begin
{$IFDEF DEBUG}
        CnDebugger.LogMsg('TCnProjectViewBaseForm Idle Fix Toolbar Button Mixed Problem: ' + IntToStr(I));
{$ENDIF}
        (ActionList.Actions[I] as TAction).Visible := True;
        (ActionList.Actions[I] as TAction).Visible := False;
      end;
    end;
  end;
  lvList.Update;
end;

function TCnProjectViewBaseForm.GetMatchMode: TCnMatchMode;
begin
  Result := mmAnywhere;

  if actMatchStart.Checked then
    Result := mmStart
  else if actMatchAny.Checked then
    Result := mmAnywhere
  else if actMatchFuzzy.Checked then
    Result := mmFuzzy;
end;

procedure TCnProjectViewBaseForm.SetMatchMode(const Value: TCnMatchMode);
begin
  actMatchStart.Checked := Value = mmStart;
  actMatchAny.Checked := Value = mmAnywhere;
  actMatchFuzzy.Checked := Value = mmFuzzy;
end;

procedure TCnProjectViewBaseForm.actMatchFuzzyExecute(Sender: TObject);
begin
  MatchMode := mmFuzzy;
  UpdateListView;
end;

procedure TCnProjectViewBaseForm.CommonUpdateListView;
var
  MatchSearchText: string;
  I, ToSelIndex: Integer;
  ToSels: TStringList;
begin
  MatchSearchText := edtMatchSearch.Text;
  ToSelIndex := 0;
  ToSels := TStringList.Create;

  DisplayList.Clear;
  try
    for I := 0 to DataList.Count - 1 do
    begin
      if (MatchSearchText = '') or CanMatchDataByIndex(MatchSearchText, MatchMode, I) then
      begin
        DisplayList.AddObject(DataList[I], DataList.Objects[I]);
        if CanSelectDataByIndex(MatchSearchText, MatchMode, I) then
          ToSels.Add(DataList[I]);
      end;
    end;

    DoSortListView;
    lvList.Items.Count := DisplayList.Count;
    lvList.Invalidate;
    UpdateStatusBar;

    // 如有需要选中的首匹配的项则选中，无则选 0，第一项
    if (ToSels.Count > 0) and (DisplayList.Count > 0) then
    begin
      for I := 0 to DisplayList.Count - 1 do
      begin
        if ToSels.IndexOf(DisplayList[I]) >= 0 then
        begin
          // DisplayList 中的第一个在 ToSelCompInfos 里头的项
          ToSelIndex := I;
          Break;
        end;
      end;
    end;
    SelectItemByIndex(ToSelIndex);
  finally
    ToSels.Free;
  end;
end;

function TCnProjectViewBaseForm.CanMatchDataByIndex(const AMatchStr: string;
  AMatchMode: TCnMatchMode; DataListIndex: Integer): Boolean;
begin
  Result := DefaultMatchHandler(AMatchStr, AMatchMode, DataListIndex);
end;

function TCnProjectViewBaseForm.CanSelectDataByIndex(
  const AMatchStr: string; AMatchMode: TCnMatchMode;
  DataListIndex: Integer): Boolean;
begin
  Result := DefaultSelectHandler(AMatchStr, AMatchMode, DataListIndex);
end;

function TCnProjectViewBaseForm.DefaultMatchHandler(
  const AMatchStr: string; AMatchMode: TCnMatchMode;
  DataListIndex: Integer): Boolean;
var
  S: string;
begin
  // 默认根据匹配模式匹配 DataList 的第 I 个字符串，
  Result := True;
  if AMatchStr = '' then
    Exit;

  S := DataList[DataListIndex];
  case AMatchMode of
    mmStart: Result := Pos(AMatchStr, S) = 1;
    mmAnywhere: Result := Pos(AMatchStr, S) > 0;
    mmFuzzy: Result := FuzzyMatchStr(AMatchStr, S);
  end;
end;

function TCnProjectViewBaseForm.DefaultSelectHandler(
  const AMatchStr: string; AMatchMode: TCnMatchMode;
  DataListIndex: Integer): Boolean;
begin
  // 默认以头匹配的优先级最高最优先选中
  Result := Pos(AMatchStr, DataList[DataListIndex]) = 1;
end;

function TCnProjectViewBaseForm.SortItemCompare(ASortIndex: Integer;
  const AMatchStr: string; const S1, S2: string;
  Obj1, Obj2: TObject): Integer;
begin
  Result := CompareStr(S1, S2);
end;

procedure TCnProjectViewBaseForm.PrepareProjectRange;
var
  I: Integer;
  AProjectInfo: TCnProjectInfo;
begin
  ProjectInfo := nil;

  if not cbbProjectList.Visible or (cbbProjectList.ItemIndex <= 0) then  // nil means All Project
  begin
    Exit;
  end
  else if cbbProjectList.ItemIndex = 1 then // 1 means Current Project
  begin
    for I := 0 to ProjectList.Count - 1 do
    begin
      AProjectInfo := TCnProjectInfo(ProjectList[I]);
      if _CnChangeFileExt(AProjectInfo.FileName, '') = CnOtaGetCurrentProjectFileNameEx then
      begin
        ProjectInfo := AProjectInfo;
        Exit;
      end;
    end;
  end
  else  // Specified Project
  begin
    for I := 0 to ProjectList.Count - 1 do
    begin
      AProjectInfo := TCnProjectInfo(ProjectList[I]);
      if cbbProjectList.Items.Objects[cbbProjectList.ItemIndex] <> nil then
      begin
        if TCnProjectInfo(cbbProjectList.Items.Objects[cbbProjectList.ItemIndex]).FileName
          = AProjectInfo.FileName then
        begin
          ProjectInfo := AProjectInfo;
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TCnProjectViewBaseForm.DoUpdateListView;
begin
  // Do Nothing in Base Class, to remove after refactoring.
end;

procedure TCnProjectViewBaseForm.ClearDataList;
var
  I: Integer;
begin
  for I := 0 to DataList.Count - 1 do
    DataList.Objects[I].Free;
  DataList.Clear;
end;

{ TCnBaseElementInfo }

constructor TCnBaseElementInfo.Create;
begin
  FMatchIndexes := TList.Create;
end;

destructor TCnBaseElementInfo.Destroy;
begin
  FMatchIndexes.Free;
  inherited;
end;

end.

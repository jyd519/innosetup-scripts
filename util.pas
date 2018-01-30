function Count(What, Where: String): Integer;
begin
   Result := 0;
    if Length(What) = 0 then
        exit;
    while Pos(What,Where)>0 do
    begin
        Where := Copy(Where,Pos(What,Where)+Length(What),Length(Where));
        Result := Result + 1;
    end;
end;


//split text to array
procedure Explode(var ADest: TArrayOfString; aText, aSeparator: String);
var tmp: Integer;
begin
    if aSeparator='' then
        exit;

    SetArrayLength(ADest,Count(aSeparator,aText)+1)

    tmp := 0;
    repeat
        if Pos(aSeparator,aText)>0 then
        begin

            ADest[tmp] := Copy(aText,1,Pos(aSeparator,aText)-1);
            aText := Copy(aText,Pos(aSeparator,aText)+Length(aSeparator),Length(aText));
            tmp := tmp + 1;

        end else
        begin

             ADest[tmp] := aText;
             aText := '';

        end;
    until Length(aText)=0;
end;


//compares two version numbers, returns -1 if vA is newer, 0 if both are identical, 1 if vB is newer
function CompareVersion(vA,vB: String): Integer;
var tmp: TArrayOfString;
    verA,verB: Array of Integer;
    i,len: Integer;
begin

    StringChange(vA,'-','.');
    StringChange(vB,'-','.');

    Explode(tmp,vA,'.');
    SetArrayLength(verA,GetArrayLength(tmp));
    for i := 0 to GetArrayLength(tmp) - 1 do
        verA[i] := StrToIntDef(tmp[i],0);

    Explode(tmp,vB,'.');
    SetArrayLength(verB,GetArrayLength(tmp));
    for i := 0 to GetArrayLength(tmp) - 1 do
        verB[i] := StrToIntDef(tmp[i],0);

    len := GetArrayLength(verA);
    if GetArrayLength(verB) < len then
        len := GetArrayLength(verB);

    for i := 0 to len - 1 do
        if verA[i] < verB[i] then
        begin
            Result := 1;
            exit;
        end else
        if verA[i] > verB[i] then
        begin
            Result := -1;
            exit
        end;

    if GetArrayLength(verA) < GetArrayLength(verB) then
    begin
        Result := 1;
        exit;
    end else
    if GetArrayLength(verA) > GetArrayLength(verB) then
    begin
        Result := -1;
        exit;
    end;

    Result := 0;
end;

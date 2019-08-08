function p = Head(pl)
    if isempty(pl)
        p = [];
    else
        p = pl(1,:);
    end
end
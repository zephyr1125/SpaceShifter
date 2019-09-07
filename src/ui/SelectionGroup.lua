SelectionGroup = class{
    init = function(self)
        self.selected = 1
        self.elements = {}
    end;
}

function SelectionGroup:add(element)
    self.elements[#self.elements+1] = element
    if #self.elements == 1 then
        element:setSelect(true)
    end
end

function SelectionGroup:Next()
    local length = #self.elements
    local selected  = self.selected+1
    if selected > length then
        selected = 1
    end
    self.selected = selected
    
    self:RefreshSelect()
end

function SelectionGroup:Prev()
    local length = #self.elements
    local selected  = self.selected-1
    if selected < 1 then
        selected = length
    end
    self.selected = selected

    self:RefreshSelect()
end

function SelectionGroup:RefreshSelect()
    for _,element in pairs(self.elements) do
        element:setSelect(false)
    end
    self.elements[self.selected]:setSelect(true)
end

function SelectionGroup:keypressed(key)
    for _,element in pairs(self.elements) do
        element:keypressed(key)
    end
end
local addon = RaidFarmTracker
addon.ui = {}

function addon.ui:CreateMainFrame()

    -- FRAME PRINCIPAL
    local frame = CreateFrame("Frame", "RaidFarmTrackerFrame", UIParent, "BackdropTemplate")

    frame:SetSize(780, 500)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetClampedToScreen(true)

    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })

    frame:SetBackdropColor(0, 0, 0, 0.9)

    -- TÍTULO
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.title:SetPoint("TOPLEFT", 12, -10)
    frame.title:SetText("|cffffd100RaidFarmTracker|r")

    -- BOTÃO FECHAR
    frame.close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    frame.close:SetPoint("TOPRIGHT", -5, -5)

    -- 🔎 SEARCH BAR
    frame.search = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
    frame.search:SetSize(300, 20)
    frame.search:SetPoint("TOPLEFT", 12, -40)
    frame.search:SetAutoFocus(false)

    frame.search:SetScript("OnEnterPressed", function(self)
        local text = self:GetText()
        addon.ui:UpdateResults(text)
        self:ClearFocus()
    end)

    -- PAINEL ESQUERDO (RAIDS)
    frame.leftPanel = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    frame.leftPanel:SetSize(220, 420)
    frame.leftPanel:SetPoint("TOPLEFT", 12, -70)
    frame.leftPanel:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    })
    frame.leftPanel:SetBackdropColor(0.1, 0.1, 0.1, 0.8)

    frame.leftTitle = frame.leftPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.leftTitle:SetPoint("TOPLEFT", 8, -8)
    frame.leftTitle:SetText("Expansões / Raids")

    -- PAINEL DIREITO (RESULTADOS)
    frame.rightPanel = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    frame.rightPanel:SetSize(520, 420)
    frame.rightPanel:SetPoint("TOPLEFT", frame.leftPanel, "TOPRIGHT", 10, 0)
    frame.rightPanel:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    })
    frame.rightPanel:SetBackdropColor(0.05, 0.05, 0.05, 0.9)

    frame.rightTitle = frame.rightPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.rightTitle:SetPoint("TOPLEFT", 8, -8)
    frame.rightTitle:SetText("Resultados")

    -- SCROLL AREA RESULTADOS
    frame.scroll = CreateFrame("ScrollFrame", nil, frame.rightPanel, "UIPanelScrollFrameTemplate")
    frame.scroll:SetPoint("TOPLEFT", 5, -30)
    frame.scroll:SetPoint("BOTTOMRIGHT", -25, 10)

    frame.content = CreateFrame("Frame", nil, frame.scroll)
    frame.content:SetSize(480, 1000)

    frame.scroll:SetScrollChild(frame.content)

    self.frame = frame

    addon:Debug("UI profissional criada")
end

-- Atualiza resultados da busca
function addon.ui:UpdateResults(query)

    local frame = self.frame
    if not frame then return end

    for _, child in ipairs({frame.content:GetChildren()}) do
        child:Hide()
    end

    local results = RaidFarmTracker:SearchItem(query)

    local y = -10

    if #results == 0 then
        local text = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetPoint("TOPLEFT", 10, y)
        text:SetText("Nenhum resultado encontrado.")
        return
    end

    for i, r in ipairs(results) do

        local line = frame.content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        line:SetPoint("TOPLEFT", 10, y)

        line:SetText(
            "|cffffd100" .. r.item.name .. "|r\n" ..
            r.boss .. " - " .. r.raid
        )

        y = y - 40

        if i >= 20 then break end
    end
end

function addon.ui:Show()
    if not self.frame then
        self:CreateMainFrame()
    end
    self.frame:Show()
end
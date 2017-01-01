module Bootstrap.Navbar
    exposing
        ( navbar
        , fixTop
        , fixBottom
        , faded
        , primary
        , success
        , info
        , warning
        , danger
        , inverse
        , brand
        , itemLink
        , customItem
        , NavbarOption
        , NavItem
        )

import Html
import Html.Attributes exposing (class)


type NavbarOption
    = NavbarFix Fix
    | NavbarScheme Scheme


type Fix
    = Top
    | Bottom


type alias Scheme =
        { modifier : LinkModifier
        , bgColor : BackgroundColor
        }


type LinkModifier
    = Dark
    | Light


type BackgroundColor
    = Faded
    | Primary
    | Success
    | Info
    | Warning
    | Danger
    | Inverse




type NavItem msg
    = NavItem (Html.Html msg)

navbar :
    { options : List NavbarOption
    , attributes : List (Html.Attribute msg)
    , items : List (NavItem msg)
    }
    -> Html.Html msg
navbar {options, attributes, items} =
    Html.nav
        ([ class <| navbarOptions options ] ++ attributes)
        [renderNav items]


renderNav : List (NavItem msg) -> Html.Html msg
renderNav navItems =
    Html.ul
        [class "nav navbar-nav"]
        (List.map (\(NavItem item) -> item) navItems)


brand : List (Html.Attribute msg) -> List (Html.Html msg) -> NavItem msg
brand attributes children =
    NavItem <|
        Html.a
            ([class "navbar-brand"] ++ attributes)
            children

itemLink : List (Html.Attribute msg) -> List (Html.Html msg) -> NavItem msg
itemLink attributes children =
    NavItem <|
        Html.li
            [class "nav-item"]
            [ Html.a
                ([class "nav-link"] ++ attributes)
                children
            ]



customItem : Html.Html msg -> NavItem msg
customItem elem =
    NavItem elem


fixTop : NavbarOption
fixTop =
    NavbarFix Top


fixBottom : NavbarOption
fixBottom =
    NavbarFix Bottom




inverse : NavbarOption
inverse =
    scheme Dark Inverse


faded : NavbarOption
faded =
    scheme Light Faded

primary : NavbarOption
primary =
    scheme Dark Primary

success : NavbarOption
success =
    scheme Dark Success

info : NavbarOption
info =
     scheme Dark Info

warning : NavbarOption
warning =
    scheme Dark Warning


danger : NavbarOption
danger =
    scheme Dark Danger


scheme : LinkModifier -> BackgroundColor -> NavbarOption
scheme modifier bgColor =
        { modifier = modifier
        , bgColor = bgColor
        }
            |> NavbarScheme


navbarOptions : List NavbarOption -> String
navbarOptions options =
    List.foldl
        (\option classString ->
            String.join " " [ classString, navbarOption option ]
        )
        "navbar"
        options


navbarOption : NavbarOption -> String
navbarOption option =
    case option of
        NavbarFix fix ->
            fixOption fix

        NavbarScheme scheme ->
            schemeOption scheme


fixOption : Fix -> String
fixOption fix =
    case fix of
        Top ->
            "navbar-fixed-top"

        Bottom ->
            "navbar-fixed-bottom"


schemeOption : Scheme -> String
schemeOption { modifier, bgColor } =
    linkModifierOption
        modifier
        ++ " "
        ++ backgroundColorOption bgColor


linkModifierOption : LinkModifier -> String
linkModifierOption modifier =
    case modifier of
        Dark ->
            "navbar-dark"

        Light ->
            "navbar-light"


backgroundColorOption : BackgroundColor -> String
backgroundColorOption bgClass =
    case bgClass of
        Faded ->
            "bg-faded"

        Primary ->
            "bg-primary"

        Success ->
            "bg-success"

        Info ->
            "bg-info"

        Warning ->
            "bg-warning"

        Danger ->
            "bg-danger"

        Inverse ->
            "bg-inverse"

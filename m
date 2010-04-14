Message-ID: <4BC5B0CF.4030607@...515...>
Date: Wed, 14 Apr 2010 15:10:55 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070505080009080705080800"
Subject: [Openvpn-devel] Finnish translation of OpenVPN-GUI for review
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070505080009080705080800
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

As promised, here's the Finnish translation for OpenVPN GUI
(http://sourceforge.net/projects/openvpn-gui). I cannot test it myself
as I don't have any Windows computers available. There might be
technical problems with it, as I had to use some Bash trickery on it.
Let me know of any problems you encounter and I'll fix them.

Btw. this translation file format is by far the most difficult one I've
ever worked with. If the app was any bigger than this, maintaining the
translation would be a pure nightmare. A separate file for each language
with translatable "key =3D value" pairs (and nothing else) would be much
better. That would allow translation and translation maintenance with
proper tools (e.g. OmegaT).

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------070505080009080705080800
Content-Type: text/plain; charset="utf-8"; name=openvpn-gui-res-fi.rc
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="openvpn-gui-res-fi.rc"

/*
 *  OpenVPN-GUI -- A Windows GUI for OpenVPN.
 *
 *  Copyright (C) 2004 Mathias Sundman <mathias@...209...>
 *                2009 Heiko Hund <heikoh@...1345...>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program (see the file COPYING included with this
 *  distribution); if not, write to the Free Software Foundation, Inc.,
 *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/* About Dialog - designed with lcc-win32 resource editor */
ID_DLG_ABOUT DIALOG 0, 0, 260, 135
STYLE WS_POPUP | WS_CAPTION | WS_SYSMENU | DS_CENTER
/* CAPTION "About - OpenVPN GUI for Windows" */
CAPTION "Tietoja OpenVPN GUI -sovelluksesta"
FONT 8, "Microsoft Sans Serif"
LANGUAGE LANG_FINNISH, SUBLANG_NEUTRAL
BEGIN
    PUSHBUTTON "OK", IDOK, 99, 115, 63, 14
    ICON ID_ICO_CONNECTED, 204, 11, 8, 21, 20
/*  LTEXT "OpenVPN GUI v" PACKAGE_VERSION " - A Windows GUI for OpenVPN", 1=
01, 40, 5, 215, 8 */
    LTEXT "OpenVPN GUI v" PACKAGE_VERSION " - Graafinen Windows-k=EF=BF=BD=
=EF=BF=BDytt=EF=BF=BD=EF=BF=BDliittym=EF=BF=BD=EF=BF=BD OpenVPN:lle", 101, =
40, 5, 215, 8

/*  LTEXT "Copyright (C) 2004-2005 Mathias Sundman <info@...454...>", 102, =
40, 15, 215, 8 */
    LTEXT "Copyright (C) 2004-2005 Mathias Sundman <info@...454...>", 102, =
40, 15, 215, 8

/*  LTEXT "http://openvpn.se/", 103, 40, 25, 215, 8 */
    LTEXT "http://openvpn.se/", 103, 40, 25, 215, 8

/*  LTEXT "OpenVPN - An application to securely tunnel IP networks " \
          "over a single UDP port, with support for SSL/TLS-based " \
          "session authentication and key exchange, packet " \
          "encryption, packet authentication, and packet compression.",
          104, 11, 51, 235, 34 */
	LTEXT "OpenVPN mahdollistaa IP-verkkojen yhdist=EF=BF=BD=EF=BF=BDmisen toi=
siinsa " \
		  "suojatulla UDP-yhteydell=EF=BF=BD=EF=BF=BD. Se tukee mm. SSL/TLS" \
		  "-pohjaista istuntojen todennusta ja avainten vaihtoa "\
		  "sek=EF=BF=BD=EF=BF=BD pakettien salausta, todennusta ja pakkausta."\

/*  LTEXT "Copyright (C) 2002-2005 OpenVPN Solutions LLC <info@...515...>",=
 105, 11, 87, 235, 11 */
    LTEXT "Copyright (C) 2002-2005 OpenVPN Solutions LLC <info@...515...>",=
 105, 11, 87, 235, 11

/*  LTEXT "http://openvpn.net/", 106, 11, 98, 235, 10 */
    LTEXT "http://openvpn.net/", 106, 11, 98, 235, 10
END

/* Passphrase Dialog */
ID_DLG_PASSPHRASE DIALOGEX 6, 18, 120, 51
STYLE WS_POPUP | WS_VISIBLE | WS_CAPTION | DS_CENTER | DS_SETFOREGROUND
EXSTYLE WS_EX_TOPMOST
/* CAPTION "OpenVPN" */
CAPTION "OpenVPN"
FONT 8, "Microsoft Sans Serif"
LANGUAGE LANG_FINNISH, SUBLANG_NEUTRAL
BEGIN
 /* LTEXT "Enter Password:", 201, 6, 6, 100, 10 */
    LTEXT "Anna salasana:", 201, 6, 6, 100, 10
    EDITTEXT ID_EDT_PASSPHRASE, 6, 17, 107, 12, ES_PASSWORD | ES_AUTOHSCROLL
/*  PUSHBUTTON "OK", IDOK, 6, 33, 50, 14 */
    PUSHBUTTON "OK", IDOK, 6, 33, 50, 14
/*  PUSHBUTTON "Cancel", IDCANCEL, 64, 33, 50, 14 */
    PUSHBUTTON "Peruuta", IDCANCEL, 64, 33, 50, 14
END

/* Auth Username/Password Dialog */
ID_DLG_AUTH DIALOG 6, 18, 160, 62
STYLE WS_POPUP | WS_VISIBLE | WS_CAPTION | DS_CENTER | DS_SETFOREGROUND
/* CAPTION "OpenVPN - User Authentication" */
CAPTION "OpenVPN - K=EF=BF=BD=EF=BF=BDytt=EF=BF=BD=EF=BF=BDj=EF=BF=BD=EF=BF=
=BDn todennus"
FONT 8, "Microsoft Sans Serif"
LANGUAGE LANG_FINNISH, SUBLANG_NEUTRAL
BEGIN
/*  LTEXT "Username:", 0, 6, 9, 50, 10 */
    LTEXT "K=EF=BF=BD=EF=BF=BDytt=EF=BF=BD=EF=BF=BDj=EF=BF=BD=EF=BF=BDnimi:=
", 0, 6, 9, 50, 10
/*  LTEXT "Password:", 0, 6, 26, 50, 10 */
    LTEXT "Salasana:", 0, 6, 26, 50, 10
    EDITTEXT ID_EDT_AUTH_USER, 60, 6, 94, 12, ES_AUTOHSCROLL
    EDITTEXT ID_EDT_AUTH_PASS, 60, 23, 94, 12, ES_PASSWORD | ES_AUTOHSCROLL
/*  PUSHBUTTON "OK", IDOK, 20, 42, 50, 14 */
    PUSHBUTTON "OK", IDOK, 20, 42, 50, 14
/*  PUSHBUTTON "Cancel", IDCANCEL, 90, 42, 52, 14 */
    PUSHBUTTON "Peruuta", IDCANCEL, 90, 42, 52, 14
END

/* Status Dialog */
ID_DLG_STATUS DIALOG 6, 18, 380, 210
STYLE WS_SIZEBOX | WS_SYSMENU | WS_MINIMIZEBOX | WS_MAXIMIZEBOX | WS_POPUP =
| WS_CAPTION | DS_CENTER
CAPTION "OpenVPN"
FONT 8, "Microsoft Sans Serif"
LANGUAGE LANG_FINNISH, SUBLANG_NEUTRAL
BEGIN
/*  LTEXT "Connecting...", ID_TXT_STATUS, 20, 5, 200, 10 */
    LTEXT "Yhdistet=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDn...", ID_TXT_STATUS=
, 20, 5, 200, 10
/*  PUSHBUTTON "Disconnect", ID_DISCONNECT, 50, 190, 50, 14 */
    PUSHBUTTON "Katkaise yhteys", ID_DISCONNECT, 50, 190, 50, 14
/*  PUSHBUTTON "Reconnect", ID_RESTART, 150, 190, 50, 14 */
    PUSHBUTTON "Yhdist=EF=BF=BD=EF=BF=BD uudelleen", ID_RESTART, 150, 190, =
50, 14
/*  PUSHBUTTON "Hide", ID_HIDE, 100, 190, 50, 14 */
    PUSHBUTTON "Piilota", ID_HIDE, 100, 190, 50, 14
END

/* Change Passphrase Dialog */
ID_DLG_CHGPASS DIALOG 6, 18, 193, 82
STYLE WS_POPUP | WS_VISIBLE | WS_CAPTION | WS_SYSMENU | DS_CENTER
/* CAPTION "OpenVPN - Change Passphrase" */
CAPTION "OpenVPN - Salasanan vaihto"
FONT 8, "Microsoft Sans Serif"
LANGUAGE LANG_FINNISH, SUBLANG_NEUTRAL
BEGIN
/*  LTEXT "Old Password:", 171, 6, 9, 85, 10 */
    LTEXT "Nykyinen salasana:", 171, 6, 9, 85, 10
/*  LTEXT "New Password:", 172, 6, 26, 85, 10 */
    LTEXT "Uusi salasana:", 172, 6, 26, 85, 10
/*  LTEXT "Confirm New Password:", 173, 6, 42, 85, 10 */
    LTEXT "Vahvista uusi salasana:", 173, 6, 42, 85, 10
    EDITTEXT ID_EDT_PASS_CUR, 95, 6, 90, 12, ES_PASSWORD | ES_AUTOHSCROLL
    EDITTEXT ID_EDT_PASS_NEW, 95, 23, 90, 12, ES_PASSWORD | ES_AUTOHSCROLL
    EDITTEXT ID_EDT_PASS_NEW2, 95, 39, 90, 12, ES_PASSWORD | ES_AUTOHSCROLL
/*  PUSHBUTTON "OK", IDOK, 40, 59, 50, 14 */
    PUSHBUTTON "OK", IDOK, 40, 59, 50, 14
/*  PUSHBUTTON "Cancel", IDCANCEL, 103, 59, 50, 14 */
    PUSHBUTTON "Peruuta", IDCANCEL, 103, 59, 50, 14
    LTEXT "", ID_TXT_KEYFORMAT, 0, 0, 0, 0
    LTEXT "", ID_TXT_KEYFILE, 0, 0, 0, 0
END

/* Proxy Settings Dialog */
ID_DLG_PROXY DIALOG 6, 18, 249, 124
STYLE WS_POPUP | WS_VISIBLE | WS_CAPTION | WS_SYSMENU | DS_CENTER
/* CAPTION "Proxy" */
CAPTION "V=EF=BF=BD=EF=BF=BDlipalvelin"
FONT 8, "Microsoft Sans Serif"
LANGUAGE LANG_FINNISH, SUBLANG_NEUTRAL
BEGIN
    GROUPBOX "   ", 201, 6, 42, 235, 52
/*  AUTORADIOBUTTON "Use OpenVPN Config-file Settings", ID_RB_PROXY_OPENVPN=
, \ */
    AUTORADIOBUTTON "K=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=EF=BF=BD asetustiedosto=
n asetuksia", ID_RB_PROXY_OPENVPN, \
                    13, 12, 200, 10, WS_GROUP | WS_TABSTOP
/*  AUTORADIOBUTTON "Use Internet Explorer Settings", \ */
    AUTORADIOBUTTON "K=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=EF=BF=BD Internet Explo=
rerin asetuksia", \
                    ID_RB_PROXY_MSIE, 13, 27, 200, 10
/*  AUTORADIOBUTTON "Manual Configuration", ID_RB_PROXY_MANUAL, 13, 42, 79,=
 10 */
    AUTORADIOBUTTON "M=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDrit=EF=BF=BD=EF=
=BF=BD asetukset itse", ID_RB_PROXY_MANUAL, 13, 42, 79, 10
/*  AUTORADIOBUTTON "HTTP Proxy", ID_RB_PROXY_HTTP, 20, 58, 90, 10, WS_GROU=
P | WS_TABSTOP */
    AUTORADIOBUTTON "HTTP-v=EF=BF=BD=EF=BF=BDlipalvelin", ID_RB_PROXY_HTTP,=
 20, 58, 90, 10, WS_GROUP | WS_TABSTOP
/*  AUTORADIOBUTTON "SOCKS Proxy", ID_RB_PROXY_SOCKS, 120, 58, 90, 10 */
    AUTORADIOBUTTON "SOCKS-v=EF=BF=BD=EF=BF=BDlipalvelin", ID_RB_PROXY_SOCK=
S, 120, 58, 90, 10
/*  LTEXT "Address:", ID_TXT_PROXY_ADDRESS, 20, 73, 32, 10 */
    LTEXT "Osoite:", ID_TXT_PROXY_ADDRESS, 20, 73, 32, 10
/*  RTEXT "Port:", ID_TXT_PROXY_PORT, 171, 73, 20, 10 */
    RTEXT "Portti:", ID_TXT_PROXY_PORT, 171, 73, 20, 10
    EDITTEXT ID_EDT_PROXY_ADDRESS, 53, 71, 117, 12, ES_AUTOHSCROLL
    EDITTEXT ID_EDT_PROXY_PORT, 196, 71, 30, 12, ES_AUTOHSCROLL
/*  AUTOCHECKBOX "Prompt for username/password when connecting.", ID_CB_PRO=
XY_AUTH, 13, 103, 183, 10 */
    AUTOCHECKBOX "Kysy k=EF=BF=BD=EF=BF=BDytt=EF=BF=BD=EF=BF=BDj=EF=BF=BD=
=EF=BF=BDnimi ja salasana yhdistett=EF=BF=BD=EF=BF=BDess=EF=BF=BD=EF=BF=BD.=
", ID_CB_PROXY_AUTH, 13, 103, 183, 10
END

/* General Settings Dialog */
ID_DLG_GENERAL DIALOGEX 6, 18, 249, 124
STYLE WS_POPUP | WS_VISIBLE | WS_CAPTION | WS_SYSMENU | DS_CENTER
/* CAPTION "General" */
CAPTION "Yleiset asetukset"
FONT 8, "Microsoft Sans Serif"
LANGUAGE LANG_FINNISH, SUBLANG_NEUTRAL
BEGIN
/*  GROUPBOX "User Interface", 201, 6, 6, 235, 30 */
    GROUPBOX "K=EF=BF=BD=EF=BF=BDytt=EF=BF=BD=EF=BF=BDliittym=EF=BF=BD=EF=
=BF=BD", 201, 6, 6, 235, 30
/*  LTEXT "Language:", ID_TXT_LANGUAGE, 17, 19, 52, 12 */
    LTEXT "Kieli:", ID_TXT_LANGUAGE, 17, 19, 52, 12
    COMBOBOX ID_CMB_LANGUAGE, 57, 17, 171, 400, CBS_DROPDOWNLIST | WS_TABST=
OP
END

/* Proxy Authentication Dialog */
ID_DLG_PROXY_AUTH DIALOG 29, 23, 154, 65
STYLE DS_CENTER | WS_POPUP | WS_VISIBLE | WS_CAPTION | DS_CENTER
/* CAPTION "OpenVPN - Proxy Authentication" */
CAPTION "OpenVPN - V=EF=BF=BD=EF=BF=BDlipalvelimen todennusasetukset"
FONT 8, "Microsoft Sans Serif"
LANGUAGE LANG_FINNISH, SUBLANG_NEUTRAL
BEGIN
/*  LTEXT "Username:", 201, 9, 8, 38, 10 */
    LTEXT "K=EF=BF=BD=EF=BF=BDytt=EF=BF=BD=EF=BF=BDj=EF=BF=BD=EF=BF=BDnimi:=
", 201, 9, 8, 38, 10
    EDITTEXT ID_EDT_PROXY_USER, 49, 5, 94, 12, ES_AUTOHSCROLL
/*  LTEXT "Password:", 202, 9, 26, 38, 10 */
    LTEXT "Salasana:", 202, 9, 26, 38, 10
    EDITTEXT ID_EDT_PROXY_PASS, 49, 23, 94, 12, ES_PASSWORD | ES_AUTOHSCROLL
/*  PUSHBUTTON "OK", IDOK, 58, 43, 40, 14 */
    PUSHBUTTON "OK", IDOK, 58, 43, 40, 14
END

STRINGTABLE
LANGUAGE LANG_FINNISH, SUBLANG_NEUTRAL
BEGIN
/*  IDS_LANGUAGE_NAME "English" */
    IDS_LANGUAGE_NAME "Suomi"

/* Tray - Resources */

/* IDS_TIP_DEFAULT "OpenVPN GUI " */=20
IDS_TIP_DEFAULT "OpenVPN GUI "
/* IDS_TIP_CONNECTED "nConnected to: " */=20
IDS_TIP_CONNECTED "nYhdistetty kohteeseen: "
/* IDS_TIP_CONNECTING "nConnecting to: " */=20
IDS_TIP_CONNECTING "nYhdistet=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDn kohteese=
en: "
/* IDS_TIP_CONNECTED_SINCE "nYhteys luotu: " */=20
IDS_TIP_CONNECTED_SINCE "nConnected since: "
/* IDS_TIP_ASSIGNED_IP "nAssigned IP: %s" */=20
IDS_TIP_ASSIGNED_IP "nIP-osoite: %s"
/* IDS_MENU_SERVICE "OpenVPN Service" */=20
IDS_MENU_SERVICE "OpenVPN-palvelu"
/* IDS_MENU_SETTINGS "Settings..." */=20
IDS_MENU_SETTINGS "Asetukset..."
/* IDS_MENU_ABOUT "About..." */=20
IDS_MENU_ABOUT "Tietoja..."
/* IDS_MENU_CLOSE "Exit" */=20
IDS_MENU_CLOSE "Poistu"
/* IDS_MENU_CONNECT "Connect" */=20
IDS_MENU_CONNECT "Yhdist=EF=BF=BD=EF=BF=BD"
/* IDS_MENU_DISCONNECT "Disconnect" */=20
IDS_MENU_DISCONNECT "Katkaise yhteys"
/* IDS_MENU_STATUS "Show Status" */=20
IDS_MENU_STATUS "N=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=EF=BF=BD tila"
/* IDS_MENU_VIEWLOG "View Log" */=20
IDS_MENU_VIEWLOG "N=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=EF=BF=BD loki"
/* IDS_MENU_EDITCONFIG "Edit Config" */=20
IDS_MENU_EDITCONFIG "Muokkaa asetuksia"
/* IDS_MENU_PASSPHRASE "Change Password" */=20
IDS_MENU_PASSPHRASE "Vaihda salasana"
/* IDS_MENU_SERVICE_START "Start" */=20
IDS_MENU_SERVICE_START "K=EF=BF=BD=EF=BF=BDynnist=EF=BF=BD=EF=BF=BD"
/* IDS_MENU_SERVICE_STOP "Stop" */=20
IDS_MENU_SERVICE_STOP "Pys=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=EF=BF=BD"
/* IDS_MENU_SERVICE_RESTART "Restart" */=20
IDS_MENU_SERVICE_RESTART "K=EF=BF=BD=EF=BF=BDynnist=EF=BF=BD=EF=BF=BD uudel=
leen"
/* IDS_MENU_SERVICEONLY_START "Connect" */=20
IDS_MENU_SERVICEONLY_START "Yhdist=EF=BF=BD=EF=BF=BD"
/* IDS_MENU_SERVICEONLY_STOP "Disconnect" */=20
IDS_MENU_SERVICEONLY_STOP "Katkaise yhteys"
/* IDS_MENU_SERVICEONLY_RESTART "Reconnect" */=20
IDS_MENU_SERVICEONLY_RESTART "Yhdist=EF=BF=BD=EF=BF=BD uudelleen"
/* IDS_MENU_ASK_STOP_SERVICE "Do you want to disconnect (Stop the OpenVPN S=
ervice)?" */=20
IDS_MENU_ASK_STOP_SERVICE "Haluatko katkaista yhteyden ja pys=EF=BF=BD=EF=
=BF=BDytt=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD OpenVPN-palvelun?"

/* Logviewer - Resources */

/* IDS_ERR_START_LOG_VIEWER "Error starting log-viewer: %s" */=20
IDS_ERR_START_LOG_VIEWER "Lokitiedoston katselimen k=EF=BF=BD=EF=BF=BDynnis=
t=EF=BF=BD=EF=BF=BDminen ep=EF=BF=BD=EF=BF=BDonnistui: %s"
/* IDS_ERR_START_CONF_EDITOR "Error starting config-editor: %s" */=20
IDS_ERR_START_CONF_EDITOR "Asetusten muokkaimen k=EF=BF=BD=EF=BF=BDynnist=
=EF=BF=BD=EF=BF=BDminen ep=EF=BF=BD=EF=BF=BDonnistui: %s"
/*  */=20

/* OpenVPN */

/* IDS_ERR_MANY_CONFIGS "OpenVPN GUI does not support more than %d configs.=
 Please contact the author if you have the need for more." */=20
IDS_ERR_MANY_CONFIGS "OpenVPN GUI:n asetustiedostoja voi olla k=EF=BF=BD=EF=
=BF=BDyt=EF=BF=BD=EF=BF=BDss=EF=BF=BD=EF=BF=BD korkeintaan %d. Ota yhteys t=
=EF=BF=BD=EF=BF=BDm=EF=BF=BD=EF=BF=BDn sovelluksen kehitt=EF=BF=BD=EF=BF=BD=
j=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDn, mik=EF=BF=BD=EF=BF=BD tarvitset use=
ampia."
/* IDS_ERR_ONE_CONN_OLD_VER "You can only have one connection running at th=
e same time when using an older version on OpenVPN than 2.0-beta6." */=20
IDS_ERR_ONE_CONN_OLD_VER "Jos k=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=EF=BF=BDss=EF=
=BF=BD=EF=BF=BD on OpenVPN 2.0-beta6 tai vanhempi, k=EF=BF=BD=EF=BF=BDyt=EF=
=BF=BD=EF=BF=BDss=EF=BF=BD=EF=BF=BD voi olla kerrallaan vain yksi yhteys."
/* IDS_ERR_STOP_SERV_OLD_VER "You cannot use OpenVPN GUI to start a connect=
ion while the OpenVPN Service is running (with OpenVPN 1.5/1.6). Stop OpenV=
PN Service first if you want to use OpenVPN GUI." */=20
IDS_ERR_STOP_SERV_OLD_VER "OpenVPN GUI -sovelluksella ei voi hallita yhteyk=
si=EF=BF=BD=EF=BF=BD, jos OpenVPN (versio 1.5/1.6) on k=EF=BF=BD=EF=BF=BDyn=
nistetty palveluna. Pys=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=EF=BF=BD OpenVPN-palve=
lu ja yrit=EF=BF=BD=EF=BF=BD uudelleen."
/* IDS_ERR_CREATE_EVENT "CreateEvent failed on exit event: %s" */=20
IDS_ERR_CREATE_EVENT "CreateEvent ep=EF=BF=BD=EF=BF=BDonnistui: %s"
/* IDS_ERR_UNKNOWN_PRIORITY "Unknown priority name: %s" */=20
IDS_ERR_UNKNOWN_PRIORITY "Tunnistamaton prioriteetti: %s"
/* IDS_ERR_LOG_APPEND_BOOL "Log file append flag (given as '%s') must be '0=
' or '1'" */=20
IDS_ERR_LOG_APPEND_BOOL "Lokitiedostoon lis=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDmisasetuksen ('%s') on oltava '0' tai '1'"
/* IDS_ERR_GET_MSIE_PROXY "Could not to get MSIE proxy settings." */=20
IDS_ERR_GET_MSIE_PROXY "Internet Explorerin v=EF=BF=BD=EF=BF=BDlipalvelinas=
etusten nouto ep=EF=BF=BD=EF=BF=BDonnistui."
/* IDS_ERR_INIT_SEC_DESC "InitializeSecurityDescriptor failed." */=20
IDS_ERR_INIT_SEC_DESC "InitializeSecurityDescriptor failed."
/* IDS_ERR_SET_SEC_DESC_ACL "SetSecurityDescriptorDacl failed." */=20
IDS_ERR_SET_SEC_DESC_ACL "SetSecurityDescriptorDacl failed."
/* IDS_ERR_CREATE_PIPE_OUTPUT "CreatePipe on hOutputWrite failed." */=20
IDS_ERR_CREATE_PIPE_OUTPUT "CreatePipe on hOutputWrite failed."
/* IDS_ERR_DUP_HANDLE_ERR_WRITE "DuplicateHandle on hErrorWrite failed." */=
=20
IDS_ERR_DUP_HANDLE_ERR_WRITE "DuplicateHandle on hErrorWrite failed."
/* IDS_ERR_CREATE_PIPE_INPUT "CreatePipe on hInputRead failed." */=20
IDS_ERR_CREATE_PIPE_INPUT "CreatePipe on hInputRead failed."
/* IDS_ERR_DUP_HANDLE_OUT_READ "DuplicateHandle on hOutputRead failed." */=
=20
IDS_ERR_DUP_HANDLE_OUT_READ "DuplicateHandle on hOutputRead failed."
/* IDS_ERR_DUP_HANDLE_IN_WRITE "DuplicateHandle on hInputWrite failed." */=
=20
IDS_ERR_DUP_HANDLE_IN_WRITE "DuplicateHandle on hInputWrite failed."
/* IDS_ERR_CLOSE_HANDLE_TMP "CloseHandle on hOutputReadTmp/hInputWriteTmp f=
ailed." */=20
IDS_ERR_CLOSE_HANDLE_TMP "CloseHandle on hOutputReadTmp/hInputWriteTmp fail=
ed."
/* IDS_ERR_CREATE_PROCESS "CreateProcess failed, exe=3D'%s' cmdline=3D'%s' =
dir=3D'%s'" */=20
IDS_ERR_CREATE_PROCESS "CreateProcess failed, exe=3D'%s' cmdline=3D'%s' dir=
=3D'%s'"
/* IDS_ERR_CLOSE_HANDLE "CloseHandle failed." */=20
IDS_ERR_CLOSE_HANDLE "CloseHandle failed."
/* IDS_ERR_CREATE_THREAD_STATUS "CreateThread to show Status window Failed.=
" */=20
IDS_ERR_CREATE_THREAD_STATUS "CreateThread to show Status window Failed."
/* IDS_NFO_STATE_WAIT_TERM "Current State: Waiting for OpenVPN to terminate=
..." */=20
IDS_NFO_STATE_WAIT_TERM "Tila: Odotetaan OpenVPN:n sammumista..."
/* IDS_ERR_OPEN_LOG_WRITE "Error opening logfile for writing: %s. You proba=
bly don't have administrator privileges, which are necessary to run OpenVPN=
." */=20
IDS_ERR_OPEN_LOG_WRITE "Virhe kirjoitettaessa lokitiedostoon: %s. Varmista,=
 ett=EF=BF=BD=EF=BF=BD OpenVPN k=EF=BF=BD=EF=BF=BDynnistet=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BDn yll=EF=BF=BD=EF=BF=BDpit=EF=BF=BD=EF=BF=BDj=EF=BF=BD=
=EF=BF=BDn oikeuksin."
/* IDS_NFO_STATE_CONNECTED "Current State: Connected" */=20
IDS_NFO_STATE_CONNECTED "Tila: Yhdistetty"
/* IDS_NFO_NOW_CONNECTED "%s is now connected." */=20
IDS_NFO_NOW_CONNECTED "%s on nyt yhdistetty."
/* IDS_NFO_ASSIGN_IP "Assigned IP: %s" */=20
IDS_NFO_ASSIGN_IP "IP-osoite: %s"
/* IDS_ERR_CERT_EXPIRED "Unable to connect because your certificate has exp=
ired or the system time is incorrect." */=20
IDS_ERR_CERT_EXPIRED "Yhdist=EF=BF=BD=EF=BF=BDminen ep=EF=BF=BD=EF=BF=BDonn=
istui, koska varmenne on vanhentunut tai tietokoneen kello on v=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDss=EF=BF=BD=EF=BF=BD ajassa."
/* IDS_ERR_CERT_NOT_YET_VALID "Unable to connect because your certificate i=
s not yet valid. Check that your system time is correct." */=20
IDS_ERR_CERT_NOT_YET_VALID "Yhdist=EF=BF=BD=EF=BF=BDminen ep=EF=BF=BD=EF=BF=
=BDonnistui, koska varmenne ei ole viel=EF=BF=BD=EF=BF=BD voimassa. Tarkist=
a, ett=EF=BF=BD=EF=BF=BD tietokoneesi kello on oikeassa ajassa."
/* IDS_NFO_STATE_RECONNECTING "Current State: Reconnecting" */=20
IDS_NFO_STATE_RECONNECTING "Tila: Yhdistet=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BDn uudelleen"
/* IDS_NFO_STATE_DISCONNECTED "Current State: Disconnected" */=20
IDS_NFO_STATE_DISCONNECTED "Tila: Yhteys katkaistu"
/* IDS_NFO_CONN_TERMINATED "Connection to %s was terminated." */=20
IDS_NFO_CONN_TERMINATED "Yhteys kohteeseen %s katkaistiin."
/* IDS_NFO_STATE_FAILED "Current State: Failed to connect" */=20
IDS_NFO_STATE_FAILED "Tila: Yhdist=EF=BF=BD=EF=BF=BDminen ep=EF=BF=BD=EF=BF=
=BDonnistui"
/* IDS_NFO_CONN_FAILED "Connecting to %s has failed." */=20
IDS_NFO_CONN_FAILED "Yhdist=EF=BF=BD=EF=BF=BDminen kohteeseen %s ep=EF=BF=
=BD=EF=BF=BDonnistui."
/* IDS_NFO_STATE_FAILED_RECONN "Current State: Failed to reconnect" */=20
IDS_NFO_STATE_FAILED_RECONN "Tila: Yhdist=EF=BF=BD=EF=BF=BDminen uudelleen =
ep=EF=BF=BD=EF=BF=BDonnistui"
/* IDS_NFO_RECONN_FAILED "ReConnecting to %s has failed." */=20
IDS_NFO_RECONN_FAILED "Yhdist=EF=BF=BD=EF=BF=BDminen uudelleen kohteeseen %=
s ep=EF=BF=BD=EF=BF=BDonnistui."
/* IDS_NFO_STATE_SUSPENDED "Current State: Suspended" */=20
IDS_NFO_STATE_SUSPENDED "Tila: Keskeytetty"
/* IDS_ERR_READ_STDOUT_PIPE "Error reading from OpenVPN StdOut Pipe." */=20
IDS_ERR_READ_STDOUT_PIPE "Lukeminen oletustulosteesta ep=EF=BF=BD=EF=BF=BDo=
nnistui."
/* IDS_ERR_CREATE_EDIT_LOGWINDOW "Creating RichEdit LogWindow Failed!!" */=
=20
IDS_ERR_CREATE_EDIT_LOGWINDOW "RichEdit LogWindowin luonti ep=EF=BF=BD=EF=
=BF=BDonnistui!"
/* IDS_ERR_SET_SIZE "Set Size failed!" */=20
IDS_ERR_SET_SIZE "Koon m=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDritt=EF=BF=BD=
=EF=BF=BDminen ep=EF=BF=BD=EF=BF=BDonnistui!"
/* IDS_ERR_AUTOSTART_CONF "Cannot find requested config to autostart: %s" *=
/=20
IDS_ERR_AUTOSTART_CONF "Ei l=EF=BF=BD=EF=BF=BDydetty automaattisesti k=EF=
=BF=BD=EF=BF=BDynnistett=EF=BF=BD=EF=BF=BDv=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD asetustiedostoa %s"
/* IDS_ERR_VERSION_CREATE_EVENT "CreateEvent() failed when checking openvpn=
 version." */=20
IDS_ERR_VERSION_CREATE_EVENT "CreateEvent() failed when checking openvpn ve=
rsion."
/* IDS_ERR_CREATE_PIPE_IN_READ "CreatePipe on hInputRead failed." */=20
IDS_ERR_CREATE_PIPE_IN_READ "CreatePipe on hInputRead failed."
/* IDS_NFO_STATE_CONNECTING "Current State: Connecting" */=20
IDS_NFO_STATE_CONNECTING "Tila: Yhdistet=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BDn"
/* IDS_NFO_CONNECTION_XXX "OpenVPN Connection (%s)" */=20
IDS_NFO_CONNECTION_XXX "OpenVPN-yhteys (%s)"
/* IDS_ERR_THREAD_READ_STDOUT "CreateThread to read openvpn process stdout =
failed." */=20
IDS_ERR_THREAD_READ_STDOUT "CreateThread to read openvpn process stdout fai=
led."
/* IDS_NFO_STATE_CONN_SCRIPT "Current State: Running Connect Script" */=20
IDS_NFO_STATE_CONN_SCRIPT "Tila: Suoritetaan yhteydenmuodostamisskripti"
/* IDS_NFO_STATE_DISCONN_SCRIPT "Current State: Running Disconnect Script" =
*/=20
IDS_NFO_STATE_DISCONN_SCRIPT "Tila: Suoritetaan yhteydenkatkaisemisskripti "
/* IDS_ERR_RUN_CONN_SCRIPT "Error running Connect Script: %s" */=20
IDS_ERR_RUN_CONN_SCRIPT "Virhe suoritettaessa yhteydenmuodostamisskripti=EF=
=BF=BD=EF=BF=BD: %s"
/* IDS_ERR_GET_EXIT_CODE "Failed to get ExitCode of Connect Script (%s)" */=
=20
IDS_ERR_GET_EXIT_CODE "Yhteydenmuodostamisskriptin (%s) poistumisarvoa ei s=
aatu "
/* IDS_ERR_CONN_SCRIPT_FAILED "Connect Script failed. (exitcode=3D%ld)" */=
=20
IDS_ERR_CONN_SCRIPT_FAILED "Yhteydenmuodostamisskriptin suorittaminen ep=EF=
=BF=BD=EF=BF=BDonnistui. (poistumisarvo=3D%ld)"
/* IDS_ERR_RUN_CONN_SCRIPT_TIMEOUT "Connect Script failed. TimeOut after %d=
 sec." */=20
IDS_ERR_RUN_CONN_SCRIPT_TIMEOUT "Yhteydenmuodostamisskriptin suorittaminen =
ep=EF=BF=BD=EF=BF=BDonnistui. Aikakatkaisu %d sekunnin j=EF=BF=BD=EF=BF=BDl=
keen."
/* IDS_ERR_CONFIG_EXIST "There already exist a config file named '%s'. You =
cannot "                          "have multiple config files with the same=
 name, even if "                          "they reside in diffrent folders.=
" */=20
IDS_ERR_CONFIG_EXIST "Asetustiedosto '%s' on jo olemassa. Asetustiedostoill=
a" \
                     "on oltava eri nimi, vaikka ne olisivatkin eri" \
                     "kansiossa."

/* main - Resources */

/* IDS_ERR_OPEN_DEBUG_FILE "Error opening debug file (%s) for output." */=20
IDS_ERR_OPEN_DEBUG_FILE "Vianj=EF=BF=BD=EF=BF=BDljitystiedostoon (%s) kirjo=
ittaminen ep=EF=BF=BD=EF=BF=BDonnistui"
/* IDS_ERR_LOAD_RICHED20 "Could not load RICHED20.DLL." */=20
IDS_ERR_LOAD_RICHED20 "Kirjaston RICHED20.DLL lataaminen ep=EF=BF=BD=EF=BF=
=BDonnistui."
/* IDS_ERR_SHELL_DLL_VERSION "Your shell32.dll version is to low (0x%lx). Y=
ou need at least version 5.0." */=20
IDS_ERR_SHELL_DLL_VERSION "Kirjasto shell32.dll on liian vanha (0x%lx), tar=
vitaan v=EF=BF=BD=EF=BF=BDhint=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDn versio =
5.0."
/* IDS_ERR_GUI_ALREADY_RUNNING "OpenVPN GUI is already running." */=20
IDS_ERR_GUI_ALREADY_RUNNING "OpenVPN GUI on jo k=EF=BF=BD=EF=BF=BDynniss=EF=
=BF=BD=EF=BF=BD."
/* IDS_NFO_SERVICE_STARTED "OpenVPN Service started." */=20
IDS_NFO_SERVICE_STARTED "OpenVPN-palvelu k=EF=BF=BD=EF=BF=BDynnistetty."
/* IDS_NFO_SERVICE_STOPPED "OpenVPN Service stopped." */=20
IDS_NFO_SERVICE_STOPPED "OpenVPN-palvelu pys=EF=BF=BD=EF=BF=BDytetty."

/* IDS_NFO_ACTIVE_CONN_EXIT "There are still active connections that will b=
e closed if you exit OpenVPN GUI." \
                         "\n\nAre you sure you want to exit?" */

IDS_NFO_ACTIVE_CONN_EXIT "Jos OpenVPN GUI suljetaan, aktiiviset yhteydet ka=
tkeavat." \
                         "\n\nHaluatko varmasti jatkaa?"

/* IDS_NFO_SERVICE_ACTIVE_EXIT "You are currently connected (the OpenVPN Se=
rvice is running). " \
                            "You will stay connected even if you exit OpenV=
PN GUI.\n\n" \
                            "Do you want to proceed and exit OpenVPN GUI?" =
*/

IDS_NFO_SERVICE_ACTIVE_EXIT "Yhteys on muodostettu OpenVPN-palvelun avulla.=
 " \
                            "Yhteydet eiv=EF=BF=BD=EF=BF=BDt katkea, vaikka=
 OpenVPN GUI suljettaisiinkin.\n\n" \
                            "\n\nSuljetaanko OpenVPN GUI?"


/* IDS_ERR_OPTION_LOG_IN_CONFIG "You have ""log"" or ""log-append"" in your=
 OpenVPN config file. These options "                                  "sho=
uld not be used with OpenVPN GUI as they prevents OpenVPN GUI from reading =
"                                  "the log output of OpenVPN which is nece=
ssary for correct operation of OpenVPN "                                  "=
GUI. The log is always written to a logfile when OpenVPN GUI is beeing used=
 "                                  "anyway, so you should remove this opti=
on.nnDo you want to proceed connecting "                                  "=
anyway?" */=20
IDS_ERR_OPTION_LOG_IN_CONFIG "OpenVPN:n asetustiedostossa on k=EF=BF=BD=EF=
=BF=BDyt=EF=BF=BD=EF=BF=BDss=EF=BF=BD=EF=BF=BD ""log"" tai ""log-append"". =
" \
							 "N=EF=BF=BD=EF=BF=BDm=EF=BF=BD=EF=BF=BD asetukset est=EF=BF=BD=EF=
=BF=BDv=EF=BF=BD=EF=BF=BDt OpenVPN GUI:ta toimimasta oikein eik=EF=BF=BD=EF=
=BF=BD niit=EF=BF=BD=EF=BF=BD " \
						     "tulisi k=EF=BF=BD=EF=BF=BDytt=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD. Vaikka asetukset eiv=EF=BF=BD=EF=BF=BDt olisikaan k=EF=BF=BD=EF=BF=BDy=
t=EF=BF=BD=EF=BF=BDss=EF=BF=BD=EF=BF=BD, OpenVPN " \
							 "GUI kirjoittaa silti lokia." \
							 "\n\nHaluatko varmasti jatkaa?"

    /* options - Resources */
    /* IDS_NFO_USAGE "--help\t\t\t: Show this message.\n" \ */
    IDS_NFO_USAGE "--help\t\t\t: N=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=EF=BF=BD t=
=EF=BF=BD=EF=BF=BDm=EF=BF=BD=EF=BF=BD viesti.\n" \
/*                "--connect cnn \t\t: Connect to ""cnn"" at startup. (exte=
nsion must be included)\n" \ */
                  "--connect cnn \t\t: Yhdist=EF=BF=BD=EF=BF=BD kohteeseen =
""cnn"" k=EF=BF=BD=EF=BF=BDynnistett=EF=BF=BD=EF=BF=BDess=EF=BF=BD=EF=BF=BD=
. Muista liitt=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD tiedostop=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BDte.\n" \
/*				  "\t\t\t   Example: openvpn-gui --connect office.ovpn\n" \ */
                  "\t\t\t   Esim.: openvpn-gui --connect toimisto.ovpn\n" \
                  "\n" \
/*                "Options to override registry settings:\n" \ */
                  "Rekisterin asetukset kumoavat valinnat:\n" \
/*                "--exe_path\t\t: Path to openvpn.exe.\n" \ */
                  "--exe_path\t\t: Polku openvpn.exe -tiedostoon.\n" \
/*                "--config_dir\t\t: Path to dir to search for config files=
 in.\n" \ */
                  "--config_dir\t\t: Polku kansioon, jossa asetustiedostot =
ovat.\n" \
/*                "--ext_string\t\t: Extension on config files.\n" \ */
                  "--ext_string\t\t: Asetustiedostojen tiedostop=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BDte.\n" \
/*                "--log_dir\t\t\t: Path to dir where log files will be sav=
ed.\n" \ */
                  "--log_dir\t\t\t: Lokitiedostojen tallennuskansio.\n" \
/*                "--priority_string\t\t: Priority string (See install.txt =
for more info).\n" \ */
                  "--priority_string\t\t: Prioriteetti (lis=EF=BF=BD=EF=BF=
=BDtietoja tiedostossa install.txt).\n" \
/*                "--append_string\t\t: 1=3DAppend to log file. 0=3DTruncat=
e logfile when connecting.\n" \ */
                  "--append_string\t\t: 1=3DLis=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD lokitiedostoon. 0=3DTypist=EF=BF=BD=EF=BF=BD lokitiedosto yhdiste=
tt=EF=BF=BD=EF=BF=BDess=EF=BF=BD=EF=BF=BD.\n" \
/*                "--log_viewer\t\t: Path to log viewer.\n" \ */
                  "--log_viewer\t\t: Lokikatselimen polku.\n" \
/*                "--editor\t\t\t: Path to config editor.\n" \ */
                  "--editor\t\t\t: Asetusten muokkaimen polku.\n" \
/*                "--allow_edit\t\t: 1=3DShow Edit Config menu item.\n" \ */
                  "--allow_edit\t\t: 1=3DN=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=EF=
=BF=BD asetusten muokkaus valikossa.\n" \
/*                "--allow_service\t\t: 1=3DShow Service control menu.\n" \=
 */
                  "--allow_service\t\t: 1=3DN=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=
=EF=BF=BD palvelujen hallinta valikossa.\n" \
/*                "--allow_password\t\t: 1=3DShow Change Password menu item=
.\n" \ */
                  "--allow_password\t\t: 1=3DN=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=
=EF=BF=BD salasanan vaihto valikossa.\n" \
/*                "--allow_proxy\t\t: 1=3DShow Proxy Settings menu.\n" \ */
                  "--allow_proxy\t\t: 1=3DN=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=EF=
=BF=BD v=EF=BF=BD=EF=BF=BDlipalvelimen asetukset valikossa.\n" \
/*                "--show_balloon\t\t: 0=3DNever, 1=3DAt initial connect, 2=
=3DAt every re-connect.\n" \ */
                  "--show_balloon\t\t: 0=3DEi koskaan, 1=3DEnsimm=EF=BF=BD=
=EF=BF=BDisen kerran yhdistett=EF=BF=BD=EF=BF=BDess=EF=BF=BD=EF=BF=BD, 2=3D=
Joka yhdistyksell=EF=BF=BD=EF=BF=BD.\n" \
/*                "--service_only\t\t: 1=3DEnable Service Only mode.\n" \ */
                  "--service_only\t\t: 1=3DK=EF=BF=BD=EF=BF=BDynnist=EF=BF=
=BD=EF=BF=BD palveluna.\n" \
/*                "--silent_connection\t\t: 1=3DDo not show the status dial=
og while connecting.\n" \ */
                  "--silent_connection\t\t: 1=3D=EF=BF=BD=EF=BF=BDl=EF=BF=
=BD=EF=BF=BD n=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=EF=BF=BD sovelluksen tilaa yhdi=
stett=EF=BF=BD=EF=BF=BDess=EF=BF=BD=EF=BF=BD.\n" \
/*                "--show_script_window\t: 0=3DHide Script execution window=
, 1=3DShow it.\n" \ */
                  "--show_script_window\t: 0=3DPiilota skriptien k=EF=BF=BD=
=EF=BF=BDynnistysikkuna, 1=3D=EF=BF=BD=EF=BF=BDl=EF=BF=BD=EF=BF=BD piilota =
sit=EF=BF=BD=EF=BF=BD.\n" \
/*                "--passphrase_attempts\t: Number of passphrase attempts t=
o allow.\n" \ */
                  "--passphrase_attempts\t: Salasanan sy=EF=BF=BD=EF=BF=BDt=
t=EF=BF=BD=EF=BF=BDkertojen maksimim=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=
=EF=BF=BD=EF=BF=BD\n" \
/*                "--connectscript_timeout\t: Time to wait for connect scri=
pt to finish.\n" \ */
                  "--connectscript_timeout\t: Yhteydenmuodostamisskriptin a=
ikakatkaisun raja.\n" \
/*                "--disconnectscript_timeout\t: Time to wait for disconnec=
t script to finish.\n" \ */
                  "--disconnectscript_timeout\t: Yhteydenkatkaisemisskripti=
n aikakatkaisun raja.\n" \
/*                "--preconnectscript_timeout\t: Time to wait for preconnec=
t script to finish.\n" */
                  "--preconnectscript_timeout\t: Ennen yhdist=EF=BF=BD=EF=
=BF=BDmist=EF=BF=BD=EF=BF=BD ajettavan skriptin aikakatkaisun raja.\n"


/* IDS_NFO_USAGECAPTION "OpenVPN GUI Usage" */=20
IDS_NFO_USAGECAPTION "OpenVPN GUI:n k=EF=BF=BD=EF=BF=BDytt=EF=BF=BD=EF=BF=
=BD"
/* IDS_ERR_BAD_PARAMETER "I'm trying to parse ""%s"" as an --option paramet=
er "                       "but I don't see a leading '--'" */=20
IDS_ERR_BAD_PARAMETER "Sy=EF=BF=BD=EF=BF=BDtteen ""%s"" k=EF=BF=BD=EF=BF=BD=
sittely --option-valitsimen " \
                      "parametrina ep=EF=BF=BD=EF=BF=BDonnistui, koska sen =
alusta puuttui '--'"
/* IDS_ERR_BAD_OPTION "Options error: Unrecognized option or missing parame=
ter(s): --%sn"=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
					  "Use openvpn-gui --help for more info." */=20
IDS_ERR_BAD_OPTION "Tuntematon valinta tai parametreja puuttuu: --%s\n" \
                   "Lis=EF=BF=BD=EF=BF=BDtietoja saa komennolla openvpn-gui=
 --help"

/* passphrase - Resources */
/* IDS_ERR_CREATE_PASS_THREAD "CreateThread to show ChangePassphrase dialog=
 failed." */=20
IDS_ERR_CREATE_PASS_THREAD "CreateThread to show ChangePassphrase dialog fa=
iled."
/* IDS_NFO_CHANGE_PWD "Change Password (%s)" */=20
IDS_NFO_CHANGE_PWD "N=EF=BF=BD=EF=BF=BDyt=EF=BF=BD=EF=BF=BD salasana (%s)"
/* IDS_ERR_PWD_DONT_MATCH "The passwords you typed do not match. Try again.=
" */=20
IDS_ERR_PWD_DONT_MATCH "Salasanant eiv=EF=BF=BD=EF=BF=BDt t=EF=BF=BD=EF=BF=
=BDsm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD. Yrit=EF=BF=BD=EF=BF=BD uudelleen"
/* IDS_ERR_PWD_TO_SHORT "Your new password must be at least %d characters l=
ong." */=20
IDS_ERR_PWD_TO_SHORT "Salasanan on oltava v=EF=BF=BD=EF=BF=BDhint=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BDn %d merkki=EF=BF=BD=EF=BF=BD pitk=EF=BF=BD=EF=
=BF=BD."
/* IDS_NFO_EMPTY_PWD "Are you sure you want to set an EMPTY password?" */=20
IDS_NFO_EMPTY_PWD "Haluatko varmasti m=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=
itt=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD TYHJ=EF=BF=BD=EF=BF=BDN salasanan?"
/* IDS_ERR_UNKNOWN_KEYFILE_FORMAT "Unknown keyfile format." */=20
IDS_ERR_UNKNOWN_KEYFILE_FORMAT "Tuntematon avaintiedoston muoto."
/* IDS_ERR_OPEN_PRIVATE_KEY_FILE "Error opening private key file (%s)." */=
=20
IDS_ERR_OPEN_PRIVATE_KEY_FILE "Virhe avattaessa yksityist=EF=BF=BD=EF=BF=BD=
 avaintiedostoa (%s)."
/* IDS_ERR_OLD_PWD_INCORRECT "The old password is incorrect." */=20
IDS_ERR_OLD_PWD_INCORRECT "Vanha salasana on virheellinen."
/* IDS_ERR_OPEN_WRITE_KEY "Error opening private key file for writing (%s).=
" */=20
IDS_ERR_OPEN_WRITE_KEY "Kirjoittaminen yksityiseen avaintiedostoon (%s) ep=
=EF=BF=BD=EF=BF=BDonnistui."
/* IDS_ERR_WRITE_NEW_KEY "Error writing new private key file (%s)." */=20
IDS_ERR_WRITE_NEW_KEY "Uuden yksityisen avaintiedoston (%s) luonti ep=EF=BF=
=BD=EF=BF=BDonnistui."
/* IDS_NFO_PWD_CHANGED "Your password has been changed." */=20
IDS_NFO_PWD_CHANGED "Salasana vaihdettu."
/* IDS_ERR_READ_PKCS12 "Error reading PKCS #12 file (%s)." */=20
IDS_ERR_READ_PKCS12 "PKCS #12 -tiedoston (%s) lukeminen ep=EF=BF=BD=EF=BF=
=BDonnistui."
/* IDS_ERR_CREATE_PKCS12 "Error creating new PKCS #12 object. Change Passwo=
rd has failed." */=20
IDS_ERR_CREATE_PKCS12 "PKCS #12 -tiedoston luonti ja salasanan vaihto ep=EF=
=BF=BD=EF=BF=BDonnistuivat."
/* IDS_ERR_OPEN_CONFIG "Could not open config file for reading: (%s)" */=20
IDS_ERR_OPEN_CONFIG "Asetustiedoston luku ep=EF=BF=BD=EF=BF=BDonnistui: (%s=
)"
/* IDS_ERR_ONLY_ONE_KEY_OPTION "You cannot have more than one ""key"" optio=
n in your config." */=20
IDS_ERR_ONLY_ONE_KEY_OPTION "Asetustiedostossa voi olla korkeintaan yksi ""=
key""-valinta."
/* IDS_ERR_ONLY_KEY_OR_PKCS12 "You cannot have both ""key"" and ""pkcs12"" =
options in your config." */=20
IDS_ERR_ONLY_KEY_OR_PKCS12 "Asetustiedostossa ei voi olla yht=EF=BF=BD=EF=
=BF=BDaikaisesti m=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDritettyn=EF=BF=BD=EF=
=BF=BD sek=EF=BF=BD=EF=BF=BD ""key"" ett=EF=BF=BD=EF=BF=BD ""pkcs12""."
/* IDS_ERR_ONLY_ONE_PKCS12_OPTION "You cannot have more than one ""pkcs12""=
 option in your config." */=20
IDS_ERR_ONLY_ONE_PKCS12_OPTION "Asetustiedostossa voi olla korkeintaan yksi=
 ""pkcs12""-valinta."
/* IDS_ERR_HAVE_KEY_OR_PKCS12 "Your config file does not contain any ""key"=
" or ""pkcs12"" option." */=20
IDS_ERR_HAVE_KEY_OR_PKCS12 "Asetustiedostossa ei ole yht=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BDn ""key""- tai ""pkcs12""-valintaa."
/* IDS_ERR_KEY_FILENAME_TO_LONG "Your key filename in the config is too lon=
g!" */=20
IDS_ERR_KEY_FILENAME_TO_LONG "Asetustiedostossa m=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BDritelty avaintiedoston nimi on liian pitk=EF=BF=BD=EF=BF=BD."
/* IDS_ERR_PASSPHRASE2STDIN "Error passing passphrase to stdin." */=20
IDS_ERR_PASSPHRASE2STDIN "Salasanan v=EF=BF=BD=EF=BF=BDlitt=EF=BF=BD=EF=BF=
=BDminen oletussy=EF=BF=BD=EF=BF=BDtteeseen ep=EF=BF=BD=EF=BF=BDonnistui."
/* IDS_ERR_AUTH_USERNAME2STDIN "Error passing auth username to stdin." */=20
IDS_ERR_AUTH_USERNAME2STDIN "K=EF=BF=BD=EF=BF=BDytt=EF=BF=BD=EF=BF=BDj=EF=
=BF=BD=EF=BF=BDnimen v=EF=BF=BD=EF=BF=BDlitt=EF=BF=BD=EF=BF=BDminen oletuss=
y=EF=BF=BD=EF=BF=BDtteeseen ep=EF=BF=BD=EF=BF=BDonnistui ."
/* IDS_ERR_AUTH_PASSWORD2STDIN "Error passing auth password to stdin." */=20
IDS_ERR_AUTH_PASSWORD2STDIN "Salasanan v=EF=BF=BD=EF=BF=BDlitt=EF=BF=BD=EF=
=BF=BDminen oletussy=EF=BF=BD=EF=BF=BDtteeseen ep=EF=BF=BD=EF=BF=BDonnistui=
."
/* IDS_ERR_CR2STDIN "Error passing CR to stdin." */=20
IDS_ERR_CR2STDIN "CR:n v=EF=BF=BD=EF=BF=BDlitt=EF=BF=BD=EF=BF=BDminen oletu=
ssy=EF=BF=BD=EF=BF=BDtteeseen ep=EF=BF=BD=EF=BF=BDonnistui."
/* IDS_ERR_INVALID_CHARS_IN_PSW "Your new password contains non-valid chara=
cters. "                              "Please choose another one." */=20
IDS_ERR_INVALID_CHARS_IN_PSW "Salasana sis=EF=BF=BD=EF=BF=BDlt=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD ep=EF=BF=BD=EF=BF=BDkelpoja merkkej=EF=BF=BD=EF=BF=
=BD ja " \
                             "sit=EF=BF=BD=EF=BF=BD on muutettava."

/* settings */
/* IDS_SETTINGS_CAPTION "OpenVPN - Settings" */=20
IDS_SETTINGS_CAPTION "OpenVPN - Asetukset"

/* proxy */

/* IDS_ERR_HTTP_PROXY_ADDRESS "You must specify a HTTP proxy address." */=20
IDS_ERR_HTTP_PROXY_ADDRESS "HTTP-v=EF=BF=BD=EF=BF=BDlipalvelimen osoite on =
m=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDritett=EF=BF=BD=EF=BF=BDv=EF=BF=BD=EF=
=BF=BD."
/* IDS_ERR_HTTP_PROXY_PORT "You must specify a HTTP proxy port." */=20
IDS_ERR_HTTP_PROXY_PORT "HTTP-v=EF=BF=BD=EF=BF=BDlipalvelimen porttion m=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDritett=EF=BF=BD=EF=BF=BDv=EF=BF=BD=EF=BF=
=BD"
/* IDS_ERR_HTTP_PROXY_PORT_RANGE "You must specify a HTTP proxy port betwee=
n 1-65535" */=20
IDS_ERR_HTTP_PROXY_PORT_RANGE "HTTP-v=EF=BF=BD=EF=BF=BDlipalvelimen portti =
on oltava v=EF=BF=BD=EF=BF=BDlilt=EF=BF=BD=EF=BF=BD 1-65535"
/* IDS_ERR_SOCKS_PROXY_ADDRESS "You must specify a SOCKS proxy address." */=
=20
IDS_ERR_SOCKS_PROXY_ADDRESS "SOCKS-v=EF=BF=BD=EF=BF=BDlipalvelimen osoite o=
n m=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDritett=EF=BF=BD=EF=BF=BDv=EF=BF=BD=
=EF=BF=BD."
/* IDS_ERR_SOCKS_PROXY_PORT "You must specify a SOCKS proxy port." */=20
IDS_ERR_SOCKS_PROXY_PORT "SOCKS-v=EF=BF=BD=EF=BF=BDlipalvelimen portti on m=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDritett=EF=BF=BD=EF=BF=BDv=EF=BF=BD=EF=
=BF=BD."
/* IDS_ERR_SOCKS_PROXY_PORT_RANGE "You must specify a SOCKS proxy port betw=
een 1-65535" */=20
IDS_ERR_SOCKS_PROXY_PORT_RANGE "SOCKS-v=EF=BF=BD=EF=BF=BDlipalvelimen portt=
i on oltava v=EF=BF=BD=EF=BF=BDlilt=EF=BF=BD=EF=BF=BD 1-65535"
/* IDS_ERR_CREATE_REG_HKCU_KEY "Error creating ""HKEY_CURRENT_USER\%s"" key=
." */=20
IDS_ERR_CREATE_REG_HKCU_KEY "Virhe luotaessa avainta ""HKEY_CURRENT_USER\%s=
""."
/* IDS_ERR_GET_TEMP_PATH "Error determining TempPath with GetTempPath(). Us=
ing ""C:\"" instead." */=20
IDS_ERR_GET_TEMP_PATH "Virhe m=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDritett=EF=
=BF=BD=EF=BF=BDess=EF=BF=BD=EF=BF=BD muuttujaa TempPath funktiolla GetTempP=
ath(). K=EF=BF=BD=EF=BF=BDytet=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDn polkua =
""C:\""."
/* IDS_ERR_CREATE_AUTH_FILE "Error creating AUTH file. (%s)" */=20
IDS_ERR_CREATE_AUTH_FILE "AUTH-tiedoston luonti ep=EF=BF=BD=EF=BF=BDonnistu=
i. (%s)"

/* service */

/* IDS_ERR_OPEN_SCMGR_ADMIN "OpenSCManager failed. You need Administrator r=
ights to start a service." */=20
IDS_ERR_OPEN_SCMGR_ADMIN "OpenSCManager kohtasi virheen. Palveluna k=EF=BF=
=BD=EF=BF=BDynnist=EF=BF=BD=EF=BF=BDminen vaatii yll=EF=BF=BD=EF=BF=BDpit=
=EF=BF=BD=EF=BF=BDj=EF=BF=BD=EF=BF=BDn oikeudet."
/* IDS_ERR_OPEN_VPN_SERVICE "Failed to open ""OpenVPNService""" */=20
IDS_ERR_OPEN_VPN_SERVICE "Palvelun ""OpenVPNService"" avaaminen ep=EF=BF=BD=
=EF=BF=BDonnistui"
/* IDS_ERR_START_SERVICE "Failed to start ""OpenVPNService""" */=20
IDS_ERR_START_SERVICE "Palvelun ""OpenVPNService"" k=EF=BF=BD=EF=BF=BDynnis=
t=EF=BF=BD=EF=BF=BDminen ep=EF=BF=BD=EF=BF=BDonnistui"
/* IDS_ERR_QUERY_SERVICE "Failed to query service status." */=20
IDS_ERR_QUERY_SERVICE "Palvelun tilan tarkistaminen ep=EF=BF=BD=EF=BF=BDonn=
istui."
/* IDS_ERR_SERVICE_START_FAILED "OpenVPN Service failed to start." */=20
IDS_ERR_SERVICE_START_FAILED "OpenVPN-palvelua ei saatu k=EF=BF=BD=EF=BF=BD=
ynnistetty=EF=BF=BD=EF=BF=BD."
/* IDS_ERR_OPEN_SCMGR "OpenSCManager failed (%d)" */=20
IDS_ERR_OPEN_SCMGR "OpenSCManager kohtasi virheen (%d)"
/* IDS_ERR_STOP_SERVICE "Failed to stop OpenVPN Service" */=20
IDS_ERR_STOP_SERVICE "OpenVPN-palvelun pys=EF=BF=BD=EF=BF=BDytt=EF=BF=BD=EF=
=BF=BDminen ep=EF=BF=BD=EF=BF=BDonnistui"
/* IDS_NFO_RESTARTED "OpenVPN Service Restarted." */=20
IDS_NFO_RESTARTED "OpenVPN-palvelu k=EF=BF=BD=EF=BF=BDynnistettiin uudellee=
n."

/* registry */
/* IDS_ERR_GET_WINDOWS_DIR "Error getting Windows Directory." */=20
IDS_ERR_GET_WINDOWS_DIR "Virhe avattaessa Windows-kansiota."
/* IDS_ERR_GET_PROGRAM_DIR "Error getting ""Program"" folder name." */=20
IDS_ERR_GET_PROGRAM_DIR "Virhe etsitt=EF=BF=BD=EF=BF=BDess=EF=BF=BD=EF=BF=
=BD ""Program""-kansion sijaintia."
/* IDS_ERR_OPEN_REGISTRY "Error opening registry for reading (HKLM\SOFTWARE=
\OpenVPN).n "                       "OpenVPN is probably not installed" */=
=20
IDS_ERR_OPEN_REGISTRY "Virhe luettaessa rekisteriavainta (HKLM\SOFTWARE\Ope=
nVPN).\n " \
                      "OpenVPN:=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD ei tode=
nn=EF=BF=BD=EF=BF=BDk=EF=BF=BD=EF=BF=BDisesti ole asennettu."
/* IDS_ERR_READING_REGISTRY "Error reading registry value (HKLM\SOFTWARE\Op=
enVPN)." */=20
IDS_ERR_READING_REGISTRY "Virhe luetteassa rekisteriavainta (HKLM\SOFTWARE\=
OpenVPN)."
/* IDS_ERR_PASSPHRASE_ATTEMPTS "Registry value ""passphrase_attempts"" must=
 be a number between 1 and 9." */=20
IDS_ERR_PASSPHRASE_ATTEMPTS "Rekisterin avaimen ""passphrase_attempts"" arv=
on on oltava v=EF=BF=BD=EF=BF=BDlilt=EF=BF=BD=EF=BF=BD 1 ja 9."
/* IDS_ERR_CONN_SCRIPT_TIMEOUT "Registry value ""connectscript_timeout"" mu=
st be a number between 0 and 99." */=20
IDS_ERR_CONN_SCRIPT_TIMEOUT "Rekisterin avaimen ""connectscript_timeout"" a=
rvon on oltava v=EF=BF=BD=EF=BF=BDlilt=EF=BF=BD=EF=BF=BD 1 ja 99"
/* IDS_ERR_DISCONN_SCRIPT_TIMEOUT "Registry value ""disconnectscript_timeou=
t"" must be a number between 1 and 99." */=20
IDS_ERR_DISCONN_SCRIPT_TIMEOUT "Rekisterin avaimen ""disconnectscript_timeo=
ut"" arvon on oltava v=EF=BF=BD=EF=BF=BDlilt=EF=BF=BD=EF=BF=BD 1 ja 99."
/* IDS_ERR_PRECONN_SCRIPT_TIMEOUT "Registry value ""preconnectscript_timeou=
t"" must be a number between 1 and 99." */=20
IDS_ERR_PRECONN_SCRIPT_TIMEOUT "Rekisterin avaimen ""preconnectscript_timeo=
ut"" arvon on oltava v=EF=BF=BD=EF=BF=BDlilt=EF=BF=BD=EF=BF=BD 1 ja 99."
/* IDS_ERR_CREATE_REG_KEY "Error creating HKLM\SOFTWARE\OpenVPN-GUI key." *=
/=20
IDS_ERR_CREATE_REG_KEY "Virhe luotaessa rekisteriavainta HKLM\SOFTWARE\Open=
VPN-GUI."
/* IDS_ERR_OPEN_WRITE_REG "Failed to open the registry for writing. You nee=
d to run this application "                        "once as Administrator t=
o update the registry." */=20
IDS_ERR_OPEN_WRITE_REG "Virhe kirjoitettaessa rekisteriin. T=EF=BF=BD=EF=BF=
=BDm=EF=BF=BD=EF=BF=BD sovellus pit=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD ens=
imm=EF=BF=BD=EF=BF=BDisell=EF=BF=BD=EF=BF=BD kerralla " \
                       "ajaa yll=EF=BF=BD=EF=BF=BDpit=EF=BF=BD=EF=BF=BDj=EF=
=BF=BD=EF=BF=BDn oikeuksin, jotta se saa lis=EF=BF=BD=EF=BF=BDtty=EF=BF=BD=
=EF=BF=BD rekisteriin tietoja."
/* IDS_ERR_READ_SET_KEY "Error reading and setting registry key ""%s""." */=
=20
IDS_ERR_READ_SET_KEY "Virhe luettaessa ja m=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BDritett=EF=BF=BD=EF=BF=BDess=EF=BF=BD=EF=BF=BD rekisteriavainta ""%s""=
."
/* IDS_ERR_WRITE_REGVALUE "Error writing registry value ""HKEY_CURRENT_USER=
\%s\%s""." */=20
IDS_ERR_WRITE_REGVALUE "Virhe kirjoitettaessa rekisterin arvoa HKEY_CURRENT=
_USER\%s\%s""."
END
















--------------070505080009080705080800--


Message-ID: <49FD9D0D.3000806@...277...>
Date: Sun, 03 May 2009 21:33:01 +0800
From: JackieKu <kjackie@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] too small font size in status window
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello openvpn-devel,

I think the font size should be increased, the following is part of 
codes from openvpn-gui (openvpn.c).

      /* Set font and fontsize of the LogWindow */
      charformat.cbSize = sizeof(CHARFORMAT);
      charformat.dwMask = CFM_SIZE | CFM_FACE | CFM_BOLD | CFM_ITALIC | \
                          CFM_UNDERLINE | CFM_STRIKEOUT | CFM_PROTECTED;
      charformat.dwEffects = 0;
      charformat.yHeight = 100;
      strcpy(charformat.szFaceName, "MS Sans Serif");

The line "charformat.yHeight = 100;" is the font size, and it means 5pt. 
Please see 
MSDN(http://msdn.microsoft.com/en-us/library/bb787881(VS.85).aspx).

**yHeight**
    Character height, in twips (1/1440 of an inch or 1/20 of a printer's
    point)

5pt is small, isn't it?

Wenzhuo Zhang wrote:
 >Matt Wilks 写道:
 >>> 1. The font size in the status window is too small for both XP and
 >>> Vista. See
 >>> http://web.zhmail.com/screenshot/20080309/OpenVPN_StatusWindow.PNG
 >>
 >>
 >> I wonder if this has something to do with your Chinese fonts. I haven't
 >> seen this on any installations I have made...
 >>
 >All font sentings are factory default in both XP and Vista. This could
 >be an issue for all CJK editions of Windows.


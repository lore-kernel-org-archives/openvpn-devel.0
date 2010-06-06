From: chantra <chantra@...1258...>
Content-Type: multipart/alternative; boundary="=-t5/gGacDMvUI/wqz+rHt"
Date: Mon, 07 Jun 2010 00:12:54 +0200
Message-ID: <1275862374.2183.61.camel@...1259...>
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Enabling Accounting/Stats for plugins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--=-t5/gGacDMvUI/wqz+rHt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

I have made a patch that would allow plugins to handle accounting
information
for each connecting clients without reading the status file.

Please see https://community.openvpn.net/openvpn/ticket/15

But for the obvious benefit that one can check regurlarly how much
bandwidth is used by a user,
it should also help in building a better radius plugin for OpenVPN.

Your comments are welcome :)

chantra

-- 
http://www.debuntu.org


!DSPAM:4c0c1d6761671268788600!

--=-t5/gGacDMvUI/wqz+rHt
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.28.3">
</HEAD>
<BODY>
Hi,<BR>
<BR>
I have made a patch that would allow plugins to handle accounting information<BR>
for each connecting clients without reading the status file.<BR>
<BR>
Please see <A HREF="https://community.openvpn.net/openvpn/ticket/15">https://community.openvpn.net/openvpn/ticket/15</A><BR>
<BR>
But for the obvious benefit that one can check regurlarly how much bandwidth is used by a user,<BR>
it should also help in building a better radius plugin for OpenVPN.<BR>
<BR>
Your comments are welcome :)<BR>
<BR>
chantra<BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<PRE>
-- 
<A HREF="http://www.debuntu.org">http://www.debuntu.org</A>
</PRE>
</TD>
</TR>
</TABLE>

!DSPAM:4c0c1d6761671268788600!

</BODY>
</HTML>



--=-t5/gGacDMvUI/wqz+rHt--




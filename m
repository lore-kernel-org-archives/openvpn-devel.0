From: chantra <chantra@...1258...>
In-Reply-To: <AANLkTilYpS47A68hRLrkMYiyHBBZlBc14lz9HCoe9GYZ@...278...>
References: <AANLkTilYpS47A68hRLrkMYiyHBBZlBc14lz9HCoe9GYZ@...278...>
Content-Type: multipart/alternative; boundary="=-nt2g5dwyInb9xO7LBSgB"
Date: Thu, 24 Jun 2010 13:58:29 +0200
Message-ID: <1277380709.2567.73.camel@...1259...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] ovpn daemon not seeing my plugin thread...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vineet Kumar <vineet.kumar@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--=-nt2g5dwyInb9xO7LBSgB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

> The reason is obviously the fact that the thread-creation occurred
> *before* the daemon() call (that forked off a child which has no way
> of inheriting a copy of that thread).
> So does this mean then that the ovpn daemon infrastructure will only
> work with plugins that don't do threading of their own?

You might want to look at 
openvpn_plugin_select_initialization_point_v1  function

as done here 
http://redmine.debuntu.org/projects/openvpn-ldap-auth/repository/revisions/master/entry/src/ldap-auth.c#L430

-- 
http://www.debuntu.org


!DSPAM:4c23486761671948424632!

--=-nt2g5dwyInb9xO7LBSgB
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.28.3">
</HEAD>
<BODY>
<BLOCKQUOTE TYPE=CITE>
<PRE>
The reason is obviously the fact that the thread-creation occurred
*before* the daemon() call (that forked off a child which has no way
of inheriting a copy of that thread).
So does this mean then that the ovpn daemon infrastructure will only
work with plugins that don't do threading of their own?
</PRE>
</BLOCKQUOTE>
You might want to look at <BR>
openvpn_plugin_select_initialization_point_v1&nbsp; function<BR>
<BR>
as done here <BR>
<A HREF="http://redmine.debuntu.org/projects/openvpn-ldap-auth/repository/revisions/master/entry/src/ldap-auth.c#L430">http://redmine.debuntu.org/projects/openvpn-ldap-auth/repository/revisions/master/entry/src/ldap-auth.c#L430</A><BR>
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

!DSPAM:4c23486761671948424632!

</BODY>
</HTML>



--=-nt2g5dwyInb9xO7LBSgB--




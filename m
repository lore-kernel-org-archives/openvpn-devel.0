From: chantra <chantra@...1258...>
In-Reply-To: <499929A843E2C541A8AD31A881A2B6A206236F74@...1006...>
References: <499929A843E2C541A8AD31A881A2B6A206236F74@...1006...>
Content-Type: multipart/alternative; boundary="=-1+QXXUnaQWZ6tczhNaD8"
Date: Wed, 16 Jun 2010 14:19:01 +0200
Message-ID: <1276690741.2615.259.camel@...1259...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] FW: Patch submission - git crash course ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David =?UTF-8?Q?Bala=C5=BEic?= <david.balazic@...1379...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

--=-1+QXXUnaQWZ6tczhNaD8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

> Is there some crash course for using git with openvpn sources?
>=20
> I know svn and other tools, but not git.
>=20
> So i need steps list like:
>=20
> apt-get install git

You should apt-get install git-core, well, at leat on some version "git"
package used to be something else.
For instance on debian http://packages.debian.org/lenny/git

Then, for crash courses, checkout
https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Testingre=
positorygit
you will find some links there that might help you


> svn co http://repo.openvpn.net/patchme # translated into git syntax
> #do your changes
> svn diff > my_patch  # again , git syntax

In a nutshell:

$ git clone
git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn-testing.git
# do changes
$ git diff > my_patch=20

 But you might rather consider
https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Community=
patchesandtheacceptanceprocessofthesepatches


>=20
> Thanks!
>=20
> David Bala=C5=BEic
>=20

chantra
--=20
http://www.debuntu.org


!DSPAM:4c18c13861671523120871!

--=-1+QXXUnaQWZ6tczhNaD8
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.28.3">
</HEAD>
<BODY>
Hi,
<BLOCKQUOTE TYPE=CITE>
<PRE>
Is there some crash course for using git with openvpn sources?

I know svn and other tools, but not git.

So i need steps list like:

apt-get install git
</PRE>
</BLOCKQUOTE>
You should apt-get install git-core, well, at leat on some version &quot;git&quot; package used to be something else.<BR>
For instance on debian <A HREF="http://packages.debian.org/lenny/git">http://packages.debian.org/lenny/git</A><BR>
<BR>
Then, for crash courses, checkout <A HREF="https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Testingrepositorygit">https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Testingrepositorygit</A><BR>
you will find some links there that might help you<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
svn co <A HREF="http://repo.openvpn.net/patchme">http://repo.openvpn.net/patchme</A> # translated into git syntax
#do your changes
svn diff &gt; my_patch  # again , git syntax
</PRE>
</BLOCKQUOTE>
<PRE>
In a nutshell:
</PRE>
$ git clone git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn-testing.git<BR>
# do changes<BR>
$ git diff &gt; my_patch <BR>
<BR>
 But you might rather consider <A HREF="https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Communitypatchesandtheacceptanceprocessofthesepatches">https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Communitypatchesandtheacceptanceprocessofthesepatches</A><BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>

Thanks!

David Bala&#382;ic

</PRE>
</BLOCKQUOTE>
chantra<BR>
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

!DSPAM:4c18c13861671523120871!

</BODY>
</HTML>



--=-1+QXXUnaQWZ6tczhNaD8--




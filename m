From: chantra <chantra@...1258...>
In-Reply-To: <1251303980.12856.9@...1207...>
References: <1251284182.4302.85.camel@...1259...>  <1251303980.12856.9@...1207...>
Content-Type: multipart/alternative; boundary="=-d+e3Lt368XzcP62w6XMW"
Date: Thu, 27 Aug 2009 16:44:03 +0200
Message-Id: <1251384243.4302.226.camel@...1259...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN with LDAP+TLS authentication runs into
	file exhaustion
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

--=-d+e3Lt368XzcP62w6XMW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Karl,

tks for opening my eyes :p, I forgot to look at the basics :s .

Today I decided to try to repro on CentOS 5.3.... to no avail:

openldap-clients-2.3.43-3.el5
openldap-2.3.43-3.el5
pam-0.99.6.2-4.el5
nss_ldap-253-17.el5
openvpn-2.0.9-1.el5.rf

Digged a bit more, and the same C program on CentOS do not open any file
handles on /dev/urandom ....
So it appears that the issue is in the openldap + lib{gnutls,ssl} part
on debian ( and debian based) only .

tks again,

On Wed, 2009-08-26 at 11:26 -0500, Karl O. Pinc wrote:

> On 08/26/2009 05:56:22 AM, chantra wrote:
> > Hi all,
> > 
> > 
> > This issue is happening on both :
> > * debian etch   openvpn 2.0.9-4etch1  libpam-ldap 180-1.7
> > * debian lenny openvpn 2.1~rc11-1  libpam-ldap 184-4.2
> 
> FWIW,
> 
> You could also try filing a bug report with debian,
> just to get more people looking at the problem.
> They might be able to come up with a patch that could
> be pushed upstream.
> 
> 
> Karl <kop@...1206...>
> Free Software:  "You don't pay back, you pay forward."
>                  -- Robert A. Heinlein
> 
> 
> 
> 
> 


!DSPAM:4a969bb690403138271407!

--=-d+e3Lt368XzcP62w6XMW
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.26.0">
</HEAD>
<BODY>
Karl,<BR>
<BR>
tks for opening my eyes :p, I forgot to look at the basics :s .<BR>
<BR>
Today I decided to try to repro on CentOS 5.3.... to no avail:<BR>
<BR>
openldap-clients-2.3.43-3.el5<BR>
openldap-2.3.43-3.el5<BR>
pam-0.99.6.2-4.el5<BR>
nss_ldap-253-17.el5<BR>
openvpn-2.0.9-1.el5.rf<BR>
<BR>
Digged a bit more, and the same C program on CentOS do not open any file handles on /dev/urandom ....<BR>
So it appears that the issue is in the openldap + lib{gnutls,ssl} part on debian ( and debian based) only .<BR>
<BR>
tks again,<BR>
<BR>
On Wed, 2009-08-26 at 11:26 -0500, Karl O. Pinc wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
On 08/26/2009 05:56:22 AM, chantra wrote:
&gt; Hi all,
&gt; 
&gt; 
&gt; This issue is happening on both :
&gt; * debian etch   openvpn 2.0.9-4etch1  libpam-ldap 180-1.7
&gt; * debian lenny openvpn 2.1~rc11-1  libpam-ldap 184-4.2

FWIW,

You could also try filing a bug report with debian,
just to get more people looking at the problem.
They might be able to come up with a patch that could
be pushed upstream.


Karl &lt;<A HREF="mailto:kop@...1206...">kop@...1206...</A>&gt;
Free Software:  &quot;You don't pay back, you pay forward.&quot;
                 -- Robert A. Heinlein





</PRE>
</BLOCKQUOTE>

!DSPAM:4a969bb690403138271407!

</BODY>
</HTML>



--=-d+e3Lt368XzcP62w6XMW--




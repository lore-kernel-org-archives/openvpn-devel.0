From: chantra <chantra@...1258...>
In-Reply-To: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBEE713B1@...1436...>
References: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBEE7137C@...1436...>
	<4CF76B01.5020308@...193...>
	<BF88BCF2F8AD5843B2250C5DB8DDE0AFBEE713B1@...1436...>
Content-Type: multipart/alternative; boundary="=-e7nO4OR+Z7rsqF0fQ3fp"
Date: Thu, 02 Dec 2010 11:19:34 +0100
Message-ID: <1291285174.2712.7.camel@...1259...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] Documentation and alternative SSL backend
	patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--=-e7nO4OR+Z7rsqF0fQ3fp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



> PolarSSL was a personal choice for us, mostly due to its simplicity and multi-platform support. The patch is written in such a way that generic operations from most libraries should work, as long as a new backend is written for them.
> 
> Adriaan 

Hi,

This seems to be a step forward to
https://community.openvpn.net/openvpn/wiki/RoadMap#OpenVPN3.0:Designandimplementation and in my opinion is an interesting addition to openvpn code.

Chantra


> 
> > -----Original Message-----
> > From: Farkas Levente [mailto:lfarkas@...193...]
> > Sent: donderdag 2 december 2010 10:47
> > To: Adriaan de Jong
> > Cc: openvpn-devel@lists.sourceforge.net
> > Subject: Re: [Openvpn-devel] Documentation and alternative SSL backend
> > patches
> > 
> > On 12/02/2010 10:05 AM, Adriaan de Jong wrote:
> > > Hi List,
> > >
> > > We've been working on OpenVPN in preparation for a security
> > evaluation. This entailed documenting OpenVPN at a relatively high
> > level, removing the dependencies on OpenSSL, and adding support for a
> > simpler, easier to evaluate library (PolarSSL).
> > >
> > > This was done in a series of patches:
> > > - Patch 1: Adds documentation to OpenVPN through Doxygen.
> > > - Patch 2: Splits out OpenSSL-specific code, defining a clean
> > "backend" interface for both the crypto and SSL modules. Splits the SSL
> > module into channel setup and verification sub-modules.
> > > - Patch 3: Adds a backend for PolarSSL.
> > >
> > > We'd love to release these patches to the community. Unfortunately,
> > the patches are now based on 2.1.4, and need to be rebased to a newer
> > version. Before we spend time on updating the patches to the current
> > revision of OpenVPN, we'd like to know whether there is an interest in
> > these patches from the community.
> > 
> > most distro switch from openssl to nss. is there any reason you switch
> > to polarssl in stead of nss?
> > 
> > --
> >   Levente                               "Si vis pacem para bellum!"
> 
> ------------------------------------------------------------------------------
> Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
> Tap into the largest installed PC base & get more eyes on your game by
> optimizing for Intel(R) Graphics Technology. Get started today with the
> Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
> http://p.sf.net/sfu/intelisp-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


-- 
http://www.debuntu.org

--=-e7nO4OR+Z7rsqF0fQ3fp
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.30.3">
</HEAD>
<BODY>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
PolarSSL was a personal choice for us, mostly due to its simplicity and multi-platform support. The patch is written in such a way that generic operations from most libraries should work, as long as a new backend is written for them.

Adriaan 
</PRE>
</BLOCKQUOTE>
Hi,<BR>
<BR>
This seems to be a step forward to <A HREF="https://community.openvpn.net/openvpn/wiki/RoadMap#OpenVPN3.0:Designandimplementation">https://community.openvpn.net/openvpn/wiki/RoadMap#OpenVPN3.0:Designandimplementation</A> and in my opinion is an interesting addition to openvpn code.<BR>
<BR>
Chantra<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>

&gt; -----Original Message-----
&gt; From: Farkas Levente [<A HREF="mailto:lfarkas@...193...">mailto:lfarkas@...193...</A>]
&gt; Sent: donderdag 2 december 2010 10:47
&gt; To: Adriaan de Jong
&gt; Cc: <A HREF="mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@lists.sourceforge.net</A>
&gt; Subject: Re: [Openvpn-devel] Documentation and alternative SSL backend
&gt; patches
&gt; 
&gt; On 12/02/2010 10:05 AM, Adriaan de Jong wrote:
&gt; &gt; Hi List,
&gt; &gt;
&gt; &gt; We've been working on OpenVPN in preparation for a security
&gt; evaluation. This entailed documenting OpenVPN at a relatively high
&gt; level, removing the dependencies on OpenSSL, and adding support for a
&gt; simpler, easier to evaluate library (PolarSSL).
&gt; &gt;
&gt; &gt; This was done in a series of patches:
&gt; &gt; - Patch 1: Adds documentation to OpenVPN through Doxygen.
&gt; &gt; - Patch 2: Splits out OpenSSL-specific code, defining a clean
&gt; &quot;backend&quot; interface for both the crypto and SSL modules. Splits the SSL
&gt; module into channel setup and verification sub-modules.
&gt; &gt; - Patch 3: Adds a backend for PolarSSL.
&gt; &gt;
&gt; &gt; We'd love to release these patches to the community. Unfortunately,
&gt; the patches are now based on 2.1.4, and need to be rebased to a newer
&gt; version. Before we spend time on updating the patches to the current
&gt; revision of OpenVPN, we'd like to know whether there is an interest in
&gt; these patches from the community.
&gt; 
&gt; most distro switch from openssl to nss. is there any reason you switch
&gt; to polarssl in stead of nss?
&gt; 
&gt; --
&gt;   Levente                               &quot;Si vis pacem para bellum!&quot;

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App &amp; Earn a Chance To Win $500!
Tap into the largest installed PC base &amp; get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
<A HREF="http://p.sf.net/sfu/intelisp-dev2dev">http://p.sf.net/sfu/intelisp-dev2dev</A>
_______________________________________________
Openvpn-devel mailing list
<A HREF="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</A>
<A HREF="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</A>

</PRE>
</BLOCKQUOTE>
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
</BODY>
</HTML>

--=-e7nO4OR+Z7rsqF0fQ3fp--




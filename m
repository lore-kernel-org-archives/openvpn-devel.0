MIME-Version: 1.0
In-Reply-To: <4CA19146.7040508@...1114...>
References: <AANLkTinJNNoewiqB2BzM6F_iwK=xctA72B2bUJpvnvUp@...278...>
	<4CA19146.7040508@...1114...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Wed, 29 Sep 2010 23:31:22 +0200
Message-ID: <AANLkTi=xg52aYnHGSH2TFCDZqL55k7r+=N6y_SMgMERA@...278...>
Subject: Re: [Openvpn-devel] Multihomed Openvpn server setup question.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Praetorian <praetoriancode@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

On Tue, Sep 28, 2010 at 8:55 AM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 28/09/10 02:04, Praetorian wrote:
>> I am settting up some servers to test the beta debian packages and
>> wanted to try a multihomed server. =A0I have two isp's coming into the
>> building and wish to make one the primarly connection side and then
>> one be the backup (ie because it is the slower of the two). =A0I looked
>> through the man page for 2.3 and did not see any settings in the
>> <connection> area to do like preferences to a group of =A0connections
>> (other than going in the order they are located in the file). =A0Also
>> once connected to the backup is there a way for it to probe when the
>> other route/connection comes back online to change back over from the
>> fall back to the prefered connection?
>>
>
> Hi,
>
> We have a report [1] that the multihome feature in OpenVPN 2.1.x on
> Debian (and most probably Gentoo) and openvpn-testing.git is broken. =A0It
> is most probably caused by a bug in the IPv6 transport patch which is
> added on Debian.
>
> I'm working on applying a fix from the developer to the
> openvpn-testing.git tree, so I hope I can manage to solve within this
> week. =A0So if you're willing to test out the 'allmerged' branch, that
> should soon fix this issue completely.

Thanks David :),

In case you wanted to try it yourself, this is the patch that solves the
multihome issue:
  http://gitorious.org/jjo/openvpn-ipv6/commit/1b96baa8fc964bfba8bfba87f1e0=
e1fbabf0b47b.patch

Cheers,

>
>
> kind regards,
>
> David Sommerseth
>
>
> [1] <https://community.openvpn.net/openvpn/ticket/28>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkyhkUYACgkQDC186MBRfroMFACeMh8jt1Y3PnQCHGviknEEyVxJ
> 66oAoJSYY1cGLa9kxxLWjModbyVevqNE
> =3DKRnF
> -----END PGP SIGNATURE-----
>
> -------------------------------------------------------------------------=
-----
> Start uncovering the many advantages of virtual appliances
> and start using them to simplify application deployment and
> accelerate your shift to cloud computing.
> http://p.sf.net/sfu/novell-sfdev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'


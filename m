Message-Id: <41566C7F-E780-4F7C-8E25-9BB5067F0C0B@...277...>
From: Davy MELINA <davy.melina@...277...>
In-Reply-To: <4856D294.1060704@...334...>
Mime-Version: 1.0 (Apple Message framework v924)
Date: Tue, 17 Jun 2008 00:57:11 +0200
References: <4856D294.1060704@...334...>
Subject: Re: [Openvpn-devel] Merge status of OCSP support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; delsp=yes; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Faidon Liambotis <paravoid@...334...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

I don't know why the OCSP support is not included in the main source=20=20
of OpenVPN (i need to update the patch for the rc7), but i know=20=20
something:

- if your CRL (in flat file) is not up2date your OpenVPN will not crash
- if you decide to use OCSP server with OpenVPN (and my patch) and if=20=20
your OCSP server crash, your OpenVPN  will be block.

For my experience, I build Two OCSPd behind LVS and i bypass this=20=20
problem.

What do you think about that ?

Regards,

Davy

Le 16 juin 08 =E0 22:52, Faidon Liambotis a =E9crit :

> Hi,
> In light of the Debian OpenSSL vulnerability, I was looking for a=20=20
> way to efficiently check for revoked certificates.
> Updating CRLs is one way but it's not exactly efficient.
>
> I've found that someone has actually implemented OCSP for OpenVPN[1].
> Is there any specific reason that this hasn't been merged?
>
> I saw evidence on the openvpn-devel archives that this was submitted=20=20
> almost a year ago but I didn't see any reviews or comments whatsoever.
>
> James, perhaps this should be included in -rc9?
>
> Regards,
> Faidon
>
> 1: http://www.block64.net/



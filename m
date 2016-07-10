MIME-Version: 1.0
In-Reply-To: <531e4123-aa78-6b00-1e10-9ff91cd445ca@...2150...>
References: <169423fa-c98c-1e3b-42e9-f4bd9165bbb5@...2150...>
	<CAKuzo_isWet5tKn3y6Wr4igEFL01UT-xAZTn3K_uka2M1c6JyQ@...278...>
	<531e4123-aa78-6b00-1e10-9ff91cd445ca@...2150...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 10 Jul 2016 13:58:58 -0400
Message-ID: <CAKuzo_jrNwhGHSFkXW4MiaoZyNFV8Jne1tU8eHyqUTECbzm74g@...278...>
Content-Type: multipart/alternative; boundary=001a11471b9c65951005374bcbb1
Subject: Re: [Openvpn-devel] [PATCH: tap-windows6] Implement option to
 disable source IP check of ARP requests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Noel Kuntze <noel@...2150...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11471b9c65951005374bcbb1
Content-Type: text/plain; charset=UTF-8

Hi,

The instructions in Selva's link weren't enough to convince windows to
> trust the driver. I had to also enable debug mode and I signed it with one
> of my own certificates.


You have to sign the driver even in test-signing mode -- only the
requirement for verified signature is not imposed so that the developer can
use a self-signed certificate. This is explained in the test-signing docs
on MSDN.

Selva

--001a11471b9c65951005374bcbb1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">The inst=
ructions in Selva&#39;s link weren&#39;t enough to convince windows to trus=
t the driver. I had to also enable debug mode and I signed it with one of m=
y own certificates.</blockquote></div><div class=3D"gmail_extra"><br></div>=
You have to sign the driver even in test-signing mode -- only the requireme=
nt for verified signature is not imposed so that the developer can use a se=
lf-signed certificate. This is explained in the test-signing docs on MSDN.<=
/div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva<=
br><br></div></div>

--001a11471b9c65951005374bcbb1--


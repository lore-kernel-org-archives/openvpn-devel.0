From: Maximilian Fillinger <maximilian.fillinger@...2507...>
Date: Mon, 12 Dec 2022 12:24:10 +0000
Message-ID: <1e23d42e6ba74b27978d94f9012a0029@...2507...>
References: <20221126162648.150678-1-maximilian.fillinger@...2507...>
 <20221126162648.150678-2-maximilian.fillinger@...2507...>
 <Y5cYjSu0D5P4QMIZ@...1296...>
In-Reply-To: <Y5cYjSu0D5P4QMIZ@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix message for too long
 tls-crypt-v2 metadata
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi!

> -----Original Message-----
> From: Gert Doering [mailto:gert@...1296...]
> Sent: maandag 12 december 2022 13:03
> To: Maximilian Fillinger <maximilian.fillinger@...2507...>
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix message for too long tls-
> crypt-v2 metadata
>=20
> Hi,
>=20
> On Sat, Nov 26, 2022 at 05:26:48PM +0100, Max Fillinger wrote:
> > The current code only checks if the base64-encoded metadata is at most
> > 980 characters. However, that can encode up to 735 bytes of data,
> while
> > only up to 733 bytes are allowed. When passing 734 or 735 bytes,
> openvpn
> > prints a misleading error message saying that the base64 cannot be
> > decoded.
> >
> > This patch checks the decoded length to show an accurate error
> message.
>=20
> This patch looks overly complex to me for "change 735 to 733" - could
> you (or Arne) explain the change a bit better?

What's going on is that the tls-crypt-v2 metadata can be at most 733 bytes.
But the metadata is supplied in base64. If you want to encode 733 bytes in
base64, you need 980 characters.

Right now, openvpn just checks that we have at most 980 base64 characters
and then tries to decode them into a 733 byte buffer. But 980 characters
of base64 can encode up to 735 bytes. In that case, openvpn gives a fatal
error about being unable to decode the base64 which I find misleading.

My patch always allocates a large enough buffer to decode the base64 and
checks that the decoded length is <=3D 733. An alternative would be to check
the base64 length, decode to a 735 bytes buffer, then check the decoded
length. I thought it's cleaner to have one length check, but I don't have
a strong opinion about this.




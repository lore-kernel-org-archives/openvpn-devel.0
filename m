References: <4bb3330d-f9eb-4e95-1514-21519d27f506@...515...>
 <7b8ffe3d-2ad5-008f-7550-1053782b139a@...515...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <e8b7f0ed-5c11-601f-90c2-d8207b096604@...1147...>
Date: Wed, 13 Mar 2019 13:13:18 +0100
MIME-Version: 1.0
In-Reply-To: <7b8ffe3d-2ad5-008f-7550-1053782b139a@...515...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 12th Mar 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

Hi Samuli,

On 13/03/19 13:00, Samuli Sepp=E4nen wrote:
> Hi,
>
> Here's the summary of the IRC meeting.
>
>
> Talked about release OpenVPN 2.x Windows installers with OpenSSL 1.1.1.
> Agreed that this makes sense as people (on forums for example) already
> take 2.4.x and replace the OpenSSL libraries forcibly. Mattock tested
> openvpn-build with OpenSSL 1.1.1b and there were no issues - a NSI
> installer was produced. The next Windows installer release will thus
> have latest OpenSSL 1.1.1 version. If serious issues are found we can
> always have separate installer releases for OpenSSL 1.1.0 and 1.1.1
> versions.
>
>
as always, thanks for the summary and chatlog; I really wanted to attend=20
this morning but got stuck in a work meeting. There was something=20
related to OpenSSL 1.1.1 support that I wanted to bring up:

OpenSSL 1.1.1 does TLS v1.3; does OpenVPN support TLS v1.3 (for the=20
control channel) already?=A0 If so, then it might be a good chance to=20
change the internal key derivation stuff in OpenVPN:

TLS < 1.2=A0=A0 --> use the sha1+md5 routines (which is basically what TLS =

itself does for TSL < 1.1
TLS >=3D 1.3 --> use the "export_keying_material" routines in OpenSSL,=20
which will create (sha2) keys for you, based on the connection parameters.

That way, we can slowly migrate users away from the sha1+md5 stuff ,=20
which will help with fips compliance as well.

Thought, anyone?

JJK

PS it would also be useful to add something to the handshake protocol to=20
allow the server to tell a *client* which version it is running; I am=20
not aware of any way to do , currently. Push-peer-info is=20
client-to-server only.




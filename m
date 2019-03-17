References: <4bb3330d-f9eb-4e95-1514-21519d27f506@...515...>
 <7b8ffe3d-2ad5-008f-7550-1053782b139a@...515...>
 <e8b7f0ed-5c11-601f-90c2-d8207b096604@...1147...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <5b77aafa-5839-42cd-0a05-3c4bfd38fde7@...1856...>
Date: Sun, 17 Mar 2019 09:46:28 +0100
MIME-Version: 1.0
In-Reply-To: <e8b7f0ed-5c11-601f-90c2-d8207b096604@...1147...>
Content-Language: en-US
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi Jan Just,

On 13-03-19 13:13, Jan Just Keijser wrote:
> On 13/03/19 13:00, Samuli Sepp=E4nen wrote:
>> Here's the summary of the IRC meeting.
>>
>> Talked about release OpenVPN 2.x Windows installers with OpenSSL 1.1.1.
>> Agreed that this makes sense as people (on forums for example) already
>> take 2.4.x and replace the OpenSSL libraries forcibly. Mattock tested
>> openvpn-build with OpenSSL 1.1.1b and there were no issues - a NSI
>> installer was produced. The next Windows installer release will thus
>> have latest OpenSSL 1.1.1 version. If serious issues are found we can
>> always have separate installer releases for OpenSSL 1.1.0 and 1.1.1
>> versions.
>>
> as always, thanks for the summary and chatlog; I really wanted to attend
> this morning but got stuck in a work meeting. There was something
> related to OpenSSL 1.1.1 support that I wanted to bring up:
>=20
> OpenSSL 1.1.1 does TLS v1.3; does OpenVPN support TLS v1.3 (for the
> control channel) already?=A0 If so, then it might be a good chance to
> change the internal key derivation stuff in OpenVPN:
>=20
> TLS < 1.2=A0=A0 --> use the sha1+md5 routines (which is basically what TLS
> itself does for TSL < 1.1
> TLS >=3D 1.3 --> use the "export_keying_material" routines in OpenSSL,
> which will create (sha2) keys for you, based on the connection parameters.
>=20
> That way, we can slowly migrate users away from the sha1+md5 stuff ,
> which will help with fips compliance as well.
>=20
> Thought, anyone?

That would have been nice, except that older OpenVPN versions compiled
against newer OpenSSL sort-of can do TLS 1.3 already. So we can't really
couple the openvpn key derivation / PRF to the TLS version (without
breaking existing setups).

I've considered moving to using the key material exporter functionality
too, and it would be cleaner for us to use. As far as I know though,
mbed TLS doesn't support that extension. And that's tricky to work
around, because the extension needs access to TLS-internal key material.
In the end I think we might be better off by simply upgrading our
internal hash.

We discussed this two hackathons ago, but it didn't make it onto the 2.5
list. Mostly because for our usage, md5+sha1 is fine (all we need is
preimage resistance, not collision resistance). But as we already agreed
back then, even if it was for appearances only, we should migrate away
from it.

-Steffan


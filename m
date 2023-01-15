Message-ID: <1ed0360c-37fb-408d-aa70-88c3f571428e@...68...>
Date: Sun, 15 Jan 2023 10:21:31 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
From: Matthias Andree <matthias.andree@...68...>
In-Reply-To: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 14.01.23 um 18:29 schrieb Arne Schwabe:
> Hey,
>
> This is the first round and will be only to the openvpn-devel list.
> After that I will also write to individuals email addresses but I want
> to start with sending this to the devel list.
>
> We are writing to you since you are or were a contributor in past to
> OpenVPN and we would like to=C2=A0 ask for your permission to amend the
> license of OpenVPN.
>
> OpenVPN 2.x is licensed under the GPL v2. This license has served us
> well in the past and we are not trying to change that. However,
> changes in licenses of our dependencies make this change necessary.
>
> Both mbed TLS and OpenSSL nowadays use the Apache 2.x license. For the
> OpenSSL library we have a special exception that allows us linking
> with it. For newer mbed TLS version, we cannot do this any more.
> Compatibility of Apache 2.x and GPL 2.x has to our knowledge never
> been tested in court and even FSF and ASF disagree about the issue
> (https://www.apache.org/licenses/GPL-compatibility.html)
>
> We would like to be able to continue to build/ship OpenVPN with mbed
> TLS. We want all contributors to ask if they agree to license change
> that adds explicit permission to link with Apache 2 licensed libraries:
>
>
> Special exception for linking OpenVPN with Apache 2 licensed libraries:
>
> =C2=A0 In addition, as a special exception, OpenVPN Inc and contributors
> =C2=A0 give permission to link the code of this program to libraries with=
 the
> =C2=A0 "APACHE LICENSE, VERSION 2.0", and distribute linked combination
> =C2=A0 including the two.=C2=A0 You must obey the GNU General Public Lice=
nse in
> =C2=A0 all respects for all of the code used other than these libraries.=
=C2=A0 If
> =C2=A0 you modify this file, you may extend this exception to your versio=
n of
> =C2=A0 the file, but you are not obligated to do so.=C2=A0 If you do not =
wish to
> =C2=A0 do so, delete this exception statement from your version.
>
>
> You might wonder why we are going for a generic Apache 2 exception
> rather than one targeted at mbed TLS specifically. We believe that a
> generic exemption is better since it also implicitly allows forks of
> mbed TLS and even if a SSL library might emerge in the future we do
> not have to discuss if it is a fork or not. Also granting an explicit
> exception for Apache 2 style licenses reaffirms the linking to OpenSSL.
>
> We also considered going for a change from GPL2 to GPL2+ but we think
> that GPL3 would hurt the ability to distribute OpenVPN as part of
> router or other embedded devices as the GPL3 has been explicitly
> developed (at least in part) to make this use case harder/impossible
> (https://en.wikipedia.org/wiki/Tivoization)
>
> If you are okay with this, please reply to this mail and confirm that.
> Otherwise we might be forced to remove and/or rewrite your code.

The GPL, in its spirit, was developed to empower users, not businesses.

So, after pondering for many hours about planned obsolescence, vendor
respect for the community, and in the light that commercial needs for
embedded uses can license the C++ reimplementation from OpenVPN Inc.:
Please reconsider amending towards "GPL2+" or "GPL3+" instead of
weakening the copyleft.



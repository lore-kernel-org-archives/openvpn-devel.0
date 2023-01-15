Message-ID: <7e0167f8-b1d3-a3f7-db40-5a441dba602f@...68...>
Date: Sun, 15 Jan 2023 14:10:19 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
 <f52172ec20da430975373e7192380874bc600062.camel@...2316...>
 <43485320-4957-8ac1-7bab-4e769000d156@...1227...>
 <234ef71a00e43f74bda0836d66c63a3d8c54a74c.camel@...2316...>
 <Y8PnGp9Rt/n9FODz@...1296...>
From: Matthias Andree <matthias.andree@...68...>
In-Reply-To: <Y8PnGp9Rt/n9FODz@...1296...>
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

Am 15.01.23 um 12:44 schrieb Gert Doering:
> Hi,
>
> On Sat, Jan 14, 2023 at 05:28:09PM -0500, James Bottomley wrote:
>> What do you mean "a source"? every apache licensed library that's
>> statically linked with a GPLv2 program would be an example of this ...
>> in the early days there was no dynamic linking, so all the early GNU
>> tools were statically linked with wodges of proprietary binary gunk.
> These "early day" precede the creation of the Apache license or GPLv2
> by many years.

Certainly not the GPLv2 (1991). GPLv3 (2007) maybe. This seems to be the
oldest converted to Git and reachable from the 2.5 and 2.6 carrying
branches:

* 6fbf66fa 2005-09-26 | This is the start of the BETA21 branch. It
includes the --topology feature, and TAP-Win32 driver changes to allow
non-admin access. [james]

I'd added OpenVPN 1.2.1 to FreeBSD in Mid 2002:
https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D39750



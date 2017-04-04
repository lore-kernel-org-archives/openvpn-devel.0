MIME-Version: 1.0
In-Reply-To: <CAKuzo_j1hHgnDuFjTt4jYZg5q1QL5U15=iiLsYT-Uao++sYACQ@...278...>
References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
	<CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
	<0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
	<95c70c5e-22ac-81ab-0fca-b9195f426f7a@...1856...>
	<a0821983-407a-dd9f-dbac-47f94a18c4dd@...515...>
	<ea1e3d78-2534-e918-5b46-ac510822415d@...1147...>
	<b0dbe975-53c0-65e0-27f3-788c3156dc11@...2080...>
	<CAKuzo_j1hHgnDuFjTt4jYZg5q1QL5U15=iiLsYT-Uao++sYACQ@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 4 Apr 2017 09:48:21 +0200
Message-ID: <CAA1AbxKDk40-RF68g-OadXtQxToH3oZ8C5B7Q7h27E1BEu-Opg@...278...>
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 3 April 2017 at 23:14, Selva Nair <selva.nair@...277...> wrote:
>
>
> On Mon, Apr 3, 2017 at 4:43 PM, David Sommerseth
> <openvpn@...2080...> wrote:
>>
>> On 03/04/17 16:12, Jan Just Keijser wrote:
>> > Hi Samuli,
>> >
>> > On 03/04/17 15:53, Samuli Sepp=C3=A4nen wrote:
>> >> On 02/04/2017 10:57, Steffan Karger wrote:
>
>
> snip..
>
>>
>> >>> DSA is _not_ a preferred choice.  The original 1024-bit DSA is too
>> >>> weak
>> >>> nowadays, and the 'larger' DSA variants are not even close to the wi=
de
>> >>> support that RSA has.
>> >>>
>> >>> -Steffan
>> >>>
>> >> Hi,
>> >>
>> >> I've issue a pull request here and review would be appreciated:
>> >>
>> >> <https://github.com/OpenVPN/easy-rsa-old/pull/1>
>> >>
>> >> I tested these changes on Debian 8 which has OpenSSL-1.0.1. Key size
>> >> was
>> >> set to 4096-bits and signature algorithm to SHA256WithRSAEncryption.
>> >>
>> >> The only real issue was DH parameter generation: it took ~25 minutes =
on
>> >> my Intel i5 laptop. Is that acceptable default behavior?
>> >>
>> > what kind of i5 is this? on my i7-4810 it took 5 minutes. Can you give
>> > the full CPUID string (from /proc/cpuinfo) ?  then I can
>> > guestimate whether the 25 minutes is realistic for slower hardware.
>>
>> I've run a a couple of "quick" tests ... on a two different laptops
>>
>> --- test 1 ----------------------------------------------------------
>> $ time openssl gendh -out test 4096
>> [...snip...]
>>
>> real    35m40.098s
>> user    35m38.922s
>> sys     0m0.367s
>> $ cat /proc/cpuinfo  | grep model\ name | uniq -c
>>       4 model name      : Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
>
>
> 4096 bit "strong" prime is indeed an intensive computation.. Is using
> -dsaparam  option not secure enough?
>
> openssl dhparam -dsaparam -out test 4096
>
> is 15 seconds vs forever without it on my ancient desktop.

From the openssl man page:

"Beware that with such DSA-style DH parameters, a fresh DH key should
be created for each use to avoid small-subgroup attacks that may be
possible otherwise."

This means that if for some reason a non-ephemeral diffie-hellman
cipher suite is selected, you are at risk of these attacks.

If you are worried about the parameter generation time, just use one
of the IETF-provided parameters, e.g:
https://tools.ietf.org/html/rfc7919#appendix-A.2

But beware that using larger groups does not only slow down parameter
generation, it also slows down connection setup.  ECDH is much faster,
but if you need to use DH, do some performance tests before blindly
using 4096-bits parameters.

-Steffan


Message-ID: <6b903268-b7d9-4bce-be1f-1732b1550590@...68...>
Date: Mon, 8 Sep 2025 21:04:23 +0200
MIME-Version: 1.0
References: <20250906135413.166789-1-matthias.andree@...68...>
 <aL6yZcbddCf7FgxN@...1296...>
Content-Language: en-US
From: Matthias Andree <matthias.andree@...68...>
In-Reply-To: <aL6yZcbddCf7FgxN@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] dco_freebsd: replace assert() by
 if...return
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

Am 08.09.25 um 12:39 schrieb Gert Doering:
> Hi,
>
> On Sat, Sep 06, 2025 at 03:54:13PM +0200, Matthias Andree via Openvpn-dev=
el wrote:
>> The assert() check might be optimized away in Release builds,
>> and killing the process through abort() when input formats are
>> bad when we already have an error message in place does not seem right.
>>
>> Suggested by: Ralf Lici <ralf@...2726...>
>>
>> Signed-off-by: Matthias Andree <matthias.andree@...68...>
> Thanks for the patch.  There has been lots of parallel work going on
> this weekend, and in the end it was decided to go for OpenVPN ASSERT()
> instead.
>
> (Committed in master and release/2.6 as of "just now")
I have updated the FreeBSD port to follow suit but backported the=20
master's patch, didn't take the one from release/2.6. Part of FreeBSD's=20
openvpn-2.6.14_3 port and package, to be consistent with upstream.


MIME-Version: 1.0
In-Reply-To: <4F9C4CF3.1040201@...1114...>
References: <1335637741-15721-1-git-send-email-alon.barlev@...277...>
	<4F9C4CF3.1040201@...1114...>
Date: Sat, 28 Apr 2012 23:10:20 +0300
Message-ID: <CAOazyz0sRO80UKa+zBtq3agJigT8xb-fkF2oJv6cJ-qBeXOw7w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: windows: convert resources to
	UTF-8
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, Apr 28, 2012 at 11:02 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 28/04/12 20:29, Alon Bar-Lev wrote:
>> Visual Studio 2010 editor supports UTF-8 files, we can store files
>> in standard encoding.
>>
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> ---
>> src/openvpn/openvpn_win32_resources.rc =C2=A0 | =C2=A0 =C2=A04 +++-
>> src/openvpnserv/openvpnserv_resources.rc | =C2=A0 =C2=A04 +++- 2 files
>> changed, 6 insertions(+), 2 deletions(-)
>
> I'm not giving it a NACK, just thinking aloud. =C2=A0Would it make the
> world simpler and easier if we just skipped this fancy copyright
> symbol with '(C)'? =C2=A0Unless there are other characters "outside 7 bit
> ASCII" table in these files, maybe that would be just as good?
>
> Just a thought.

Well, we can write plain ASCII "(C)"...
But in Windows in most cases the unicode (C) character is used...
Now finally that Visual studio supports UTF-8, it is even simpler
(possible) to maintain UTF-8 only tree!
So question was correct to old times, now there is no overhead.

Alon.


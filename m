Message-ID: <57C03BE2.1060208@...1147...>
Date: Fri, 26 Aug 2016 14:53:54 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <326b8ff7-39a6-1974-c0b0-82fd2abdc7b7@...277...>
	<20160826121023.GX78279@...1296...>
In-Reply-To: <20160826121023.GX78279@...1296...>
Subject: Re: [Openvpn-devel] 2.3.12 vs git-master with cipher negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 26/08/16 14:10, Gert Doering wrote:
> Hi,
>
> On Thu, Aug 25, 2016 at 04:17:25PM +0100, debbie10t wrote:
>> Now server cannot negotiate --cipher and is set at AES-256-CBC
>> Connecting linux client cannot renegotiate --cipher and is set at
>> AES-256-GCM
>> On --ping-restart --cipher is not reset and so the client can no longer
>> connect.
> This is a problem indeed, thanks for noticing and clearly describing it.
>
> (In other words: upon reconnection, the --cipher setting should be
> "what is in the config", not "what was negotiated in a previous connect",
> so it needs to be stored in a session-dependent variable internally, and
> not override the config variable - which makes the code less nice...)
>
> Steffan, are you listening? ;-)
>
FWIW: this is not a new problem, it just happens to show up now; if you do a
   push "cipher aes-128-cbc"
on a v2.3 server it will happily push it (even a v2.1 server would). The 
connection would not be established (unless the client happened to use 
"cipher aes-128-cbc" already) but after a reconnect the connection 
*would* work.
I'm not saying it shouldn't be fixed, I'm just saying that this is not 
"new" behaviour.

HTH,

JJK



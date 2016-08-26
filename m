MIME-Version: 1.0
In-Reply-To: <20160826121023.GX78279@...1296...>
References: <326b8ff7-39a6-1974-c0b0-82fd2abdc7b7@...277...>
	<20160826121023.GX78279@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Fri, 26 Aug 2016 15:15:03 +0200
Message-ID: <CAA1AbxKuE4LGUdDu22BESL7nGoVK8NRZkebgHrpFvqO502DAYw@...278...>
Subject: Re: [Openvpn-devel] 2.3.12 vs git-master with cipher negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 26 August 2016 at 14:10, Gert Doering <gert@...1296...> wrote:
> On Thu, Aug 25, 2016 at 04:17:25PM +0100, debbie10t wrote:
>> Now server cannot negotiate --cipher and is set at AES-256-CBC
>> Connecting linux client cannot renegotiate --cipher and is set at
>> AES-256-GCM
>> On --ping-restart --cipher is not reset and so the client can no longer
>> connect.
>
> This is a problem indeed, thanks for noticing and clearly describing it.
>
> (In other words: upon reconnection, the --cipher setting should be
> "what is in the config", not "what was negotiated in a previous connect",
> so it needs to be stored in a session-dependent variable internally, and
> not override the config variable - which makes the code less nice...)
>
> Steffan, are you listening? ;-)

Yes, I am, and I agree that this needs to be fixed.  This could also
cause problems when roaming from one server to the next.  Just didn't
find time to respond yet.  It's on my list.

-Steffan


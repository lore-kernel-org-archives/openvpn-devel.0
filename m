MIME-Version: 1.0
In-Reply-To: <20160421203643.GM53051@...1296...>
References: <1461270286-3549-1-git-send-email-janjust@...1147...>
	<571937C6.5000102@...1147...> <20160421203643.GM53051@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 21 Apr 2016 23:56:48 +0200
Message-ID: <CAA1Abx+hwEj9MTAfSCU+qvECgMvLi-YfbDM_X1iKvhP=P_h1mQ@...278...>
Subject: Re: [Openvpn-devel] Add support for pushable encryption.
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Thu, Apr 21, 2016 at 10:36 PM, Gert Doering <gert@...1296...> wrote:
> On Thu, Apr 21, 2016 at 10:27:50PM +0200, Jan Just Keijser wrote:
>> there are a few notes about this patch:
>>
>> - I've tested it on Linux only
>> - it works when pushing both --cipher andi/or --auth
>> - works by re-doing part of the encryption setup (you'll see some
>> messages fly by twice )
>> - pushing an HMAC (e.g. push "auth SHA256"") does **not** work in
>> combination with --tls-auth: when tls-auth is used all incoming packets
>> are signed using the "original" HMAC cipher and you won't even get to
>> the "push" stage to get the correct cipher.
>
> Does it work on the server side, that is, having a ccd/ file or script
> that tells the server "cipher <foo>" for a given client?

No, this is client-side support to accept pushed ciphers.  This is no
multi-cipher support on the server side.

> Otherwise: impressive :-) (I leave the actual code review to Steffan)

Very cool indeed!  We already had some discussion on #openvpn-devel.
Some minor things popped up, but I'll let that settle a bit before
really getting into it on the list.

-Steffan


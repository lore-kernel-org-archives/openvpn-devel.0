MIME-Version: 1.0
In-Reply-To: <56B8BA7C.4020707@...1400...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-8-git-send-email-steffan@...1856...>
	<56B8BA7C.4020707@...1400...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 8 Feb 2016 22:54:51 +0100
Message-ID: <CAA1Abx+9W7vXSOgN=qk6f1oJJGmrXdn6fLQNzZjcsEZcGxEnUQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 07/10] Create separate function for
	replay check
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
To: Arne Schwabe <schwabe@...1400...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Feb 8, 2016 at 4:55 PM, Arne Schwabe <schwabe@...1400...> wrote:
> Am 07.02.16 um 20:47 schrieb Steffan Karger:
>> In preparation for AEAD cipher modes, which will need the same
>> functionality.
>>
>> Should not change any behaviour.
>
> ACK. Passing gc instead of using an own gc does not really matter in
> this case.

I chose to pass the gc for performance reasons.  Passing the gc should
be faster (even 'free' if the compiler decides to inline).  This is in
the critical path for packet processing, so I tried to keep overhead
to a minimum.

-Steffan


MIME-Version: 1.0
In-Reply-To: <b3f65c74-2b47-2a1b-1cab-c084e636a1ae@...1227...>
References: <1465388443-15484-1-git-send-email-steffan@...1856...>
	<1465388443-15484-4-git-send-email-steffan@...1856...>
	<b3f65c74-2b47-2a1b-1cab-c084e636a1ae@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 8 Jun 2016 17:01:26 +0200
Message-ID: <CAA1AbxJnXgR_Ku6OA3wua2nDr8msH1g0sr0c3xSAUPbs0yaaXQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/5] Add client-side support for cipher
	negotiation
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Wed, Jun 8, 2016 at 4:23 PM, Arne Schwabe <arne@...1227...> wrote:
>
>> +#ifdef ENABLE_CRYPTO
>> +  if (c->options.pull)
>> +    {
>> +      /* If we use --pull, we don't know the crypto overhead yet. */
>> +      msg (M_WARN, "*** Account for max crypto overhead ***");
>
> That message will surely confuse users.

Oops, that should not have been there anymore.

FYI - (as reported by Arne on IRC) this patch still has some issues
when used with TCP mode.  I'm working on a v2, coming soon :)

-Steffan


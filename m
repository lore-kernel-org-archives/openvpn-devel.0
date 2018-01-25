References: <1516423974-22159-1-git-send-email-selva.nair@...277...>
 <201801251118.w0PBIn3d083413@...2054...>
 <CAKuzo_i5qGrDQoJK8nb0P2WQHQnRmBzxR_m6W56Y5gq5HhnfFA@...278...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <857ede9e-80ec-fab5-7c57-00873ed2e33f@...1435...>
Date: Thu, 25 Jan 2018 18:00:44 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i5qGrDQoJK8nb0P2WQHQnRmBzxR_m6W56Y5gq5HhnfFA@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: TLS v1.2 support for
 cryptoapicert -- RSA only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 25-01-18 16:14, Selva Nair wrote:
> A more useful thing to do is to catch the case of user setting min =
> 1.2 (as in trac 977) and we changing max to 1.1 when key is in a
> legacy key store. That would cause a handshake failure with a cryptic
> error. Better to catch early with a helpful warning. Will consider a
> patch for that and trim down the above log message at that time.

Ah, I actually have a patch ready for that in my local master branch,
but still needed to send it out.  So if you haven't started yet, I can
send that out to the list.  Otherwise I'll happily discard mine :)

-Steffan


MIME-Version: 1.0
In-Reply-To: <857ede9e-80ec-fab5-7c57-00873ed2e33f@...1435...>
References: <1516423974-22159-1-git-send-email-selva.nair@...277...>
 <201801251118.w0PBIn3d083413@...2054...>
 <CAKuzo_i5qGrDQoJK8nb0P2WQHQnRmBzxR_m6W56Y5gq5HhnfFA@...278...>
 <857ede9e-80ec-fab5-7c57-00873ed2e33f@...1435...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 25 Jan 2018 13:08:20 -0500
Message-ID: <CAKuzo_hkSd8PJsfNJ9pTNqdh8mOcaoxr-+kx_d7EayPE6+3w0w@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Jan 25, 2018 at 12:00 PM, Steffan Karger
<steffan.karger@...1435...> wrote:
> On 25-01-18 16:14, Selva Nair wrote:
>> A more useful thing to do is to catch the case of user setting min =
>> 1.2 (as in trac 977) and we changing max to 1.1 when key is in a
>> legacy key store. That would cause a handshake failure with a cryptic
>> error. Better to catch early with a helpful warning. Will consider a
>> patch for that and trim down the above log message at that time.
>
> Ah, I actually have a patch ready for that in my local master branch,
> but still needed to send it out.  So if you haven't started yet, I can
> send that out to the list.  Otherwise I'll happily discard mine :)

No, I'll defer to you, I haven't written one. Was just looking into it
and realized it may require a better get_min_proto_version
compatibility function (current one returns 0).

Thanks,

Selva


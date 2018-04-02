References: <1520817479-17203-1-git-send-email-selva.nair@...277...>
 <2a4823ad-f915-610e-d3e6-5fc04abea366@...1856...>
 <CAKuzo_jkwr-9yweCb5jufTmdjo-Oz1odqE0QDR=GWZfDQc3-GQ@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <18b889b2-6c9e-b8ad-d86f-f51441e5b731@...1856...>
Date: Mon, 2 Apr 2018 18:04:03 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jkwr-9yweCb5jufTmdjo-Oz1odqE0QDR=GWZfDQc3-GQ@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Skip expired certificates in
 Windows certificate store
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 02-04-18 16:58, Selva Nair wrote:
> On Mon, Apr 2, 2018 at 8:37 AM, Steffan Karger <steffan@...1856...> wrote:
>> Also, this looks like a somewhat unrelated fix.  I would have personally
>> preferred it in a separate patch (so we can e.g. backport it easily even
>> if we decide not not backport the functional change).
> 
> The original did the search based on subject and hash separately,
> which is now combined into a loop below this parsing chunk. So a
> return, in place of break, is required here. The warning on parse error
> is new (instead of silently returning NULL). But the end result of that
> is still a FATAL error later in the code, as before.
> 
> I'm ok to leave out the warning from this patch, though..

Ah, ok.  If it's not independent, let's just keep it in this patch.

-Steffan


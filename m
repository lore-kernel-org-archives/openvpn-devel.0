Message-ID: <e77e551b-91f8-5fe8-2f3d-41751b568e4e@...2181...>
Date: Thu, 11 Nov 2021 15:34:19 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <CAAYFXLmcybkvkw0RJ5gPVhkxrYKRr4XkdPUJwB4Cm--jQjdXKQ@...278...>
 <764146725.499610.1636544169460@...2642...>
 <CAAYFXLnJSMBcrN70GnaHRfREEosTPM-J8pZFw98DtkbNaZPKSA@...278...>
 <YY0bykbHVuGLY3DI@...1296...>
 <CAAYFXLnbfBkE7OAwOqdoQJxNt-M1aWLTcYD32Z662h-0Oc-NiA@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAAYFXLnbfBkE7OAwOqdoQJxNt-M1aWLTcYD32Z662h-0Oc-NiA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] boolean short-circuit auth upon failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Pete Nelson <petiepooo@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 11/11/2021 15:26, Pete Nelson wrote:
> Should that have shown up as a separate entry in patchworks?  I'm having 
> to cut/paste the results of git format-patch as I can't git send-email 
> from my dev box, and it looks like I may have missed editing the subject 
> line.

It shows up when it is detected as a proper new patch (maybe using the 
exact same subject fooled the detection?).

You can pass -v2 also to git format-patch, so it will edit the subject 
for you.

In any case, I'd suggest fixing git-send-email as copy/paste may 
introduce all kind of formatting bugs and may make the patch unusable.

Cheers,

-- 
Antonio Quartulli


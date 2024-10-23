Message-ID: <56038512-a84a-4bb7-a1e0-38a0d4f99b70@...277...>
Date: Wed, 23 Oct 2024 18:48:11 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20241023134903.66485-1-rzvncj@...277...>
 <ZxkG_T7Jw7fI-C1I@...1296...>
 <4bf82643-74b0-4034-a4e1-67d0ac3ce51b@...277...>
 <ZxkLm_LadCi16JTV@...1296...>
 <b2c9b370-43b8-40c3-843b-adeabef79891@...277...>
 <ZxkNPBAus8JGMehg@...1296...>
 <babedac6-d487-4df6-b054-b961209be459@...277...>
 <CAKuzo_ifn6ma288DdFNm_=AURyU+uneuxo5HWuB6FHXTCDpVrQ@...278...>
From: Razvan Cojocaru <rzvncj@...277...>
In-Reply-To: <CAKuzo_ifn6ma288DdFNm_=AURyU+uneuxo5HWuB6FHXTCDpVrQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Allow setting an empty auth-token in
 push replies
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
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On 10/23/24 18:25, Selva Nair wrote:
> Wouldn't pushing "HALT" instead of "AUTH_FAILED" work in this case?
> As in the management command "client-kill {cid} HALT" which calls
> send_restart() with kill_msg = "HALT".

Possibly, however the intent has always been to use this feature to 
reject (authorize) clients (so this is a corner case of that, just that 
we can retract authorization at a later time), and in addition 
considerable work has already been done that relies on the AUTH_FAILED 
code paths.


Thanks,
Razvan


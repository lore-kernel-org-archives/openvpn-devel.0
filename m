References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <08bd22b6-8fc4-fa8b-f5f7-b7b3a8100a15@...2181...>
Date: Tue, 14 Jul 2020 10:36:08 +0200
MIME-Version: 1.0
In-Reply-To: <20200711093655.23686-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5 02/14] client-connect: Split
 multi_connection_established into separate functions
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 11/07/2020 11:36, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
> 
> This patch splits up the multi_connection_established() function.  Each new
> helper function does a specific job.  Functions that do a similar job receive a
> similar calling interface.
> 
> The patch tries not to reindent code, so that the real changes are as clearly
> visible as possible.  (A follow-up patch will only do indentation changes.)
> 
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> 
> PATCH v3: Since the code has changed enough from the time the original patch
> to the current master, the splitting has been redone from the current code.
> Also some style and minor code changes have been added doing this patch.
> This elimininates and the big reformatting done before eliminates the follow
> up patch with indentation changes.
> 
> The original patch already replaces some instances of option_permission_mask
> with CLIENT_CONNECT_OPT_MASK. The V3 version does this more consistenly.
> 
> Patch v4: Move config -> mi->cc_config into its own commit
> 
> Patch v5: Clean up some minor issues, add one missing check on
> temporary file deletion, rebase on latest master.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Thanks for taking care of my concerns.

The patch looks good and does what it says. Unfortunately the code
itself is already pretty convoluted, so this refactoring patch looks
convoluted as well...but after looking through it the change is minimal.


Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli


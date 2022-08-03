Date: Wed, 3 Aug 2022 11:10:02 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Yuo7asoe8DELkq7K@...2685...>
References: <20220728193542.14801-1-a@...2181...>
 <20220802151604.2801-1-a@...2181...>
MIME-Version: 1.0
In-Reply-To: <20220802151604.2801-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 10/25] dco: periodically check and
 possibly rotate/delete keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, Aug 02, 2022 at 05:16:04PM +0200, Antonio Quartulli wrote:
> Data channel keys are periodically regenarated and installed in
> ovpn-dco.
> However, there is a certain moment when keys are rotated in order
> to elect the new primary one.
> 
> Check the key status in userspace so that kernelspace can be informed as
> well when rotations happen.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> Changes from v2:
> * reworked dco_update_keys():
> ** removed existing ASSERTs on keys and converted into something more
>    logic and related to the flow
> ** fixed comment about userspace (use "we" for more clarity)
> ** add error code handling. The idea is to abort operations as soon as a
>    failure is detected, so that the next iteration can make another
>    attempt.

Looks to me like this addresses all my comments.

Regards,
-- 
  Frank Lichtenheld


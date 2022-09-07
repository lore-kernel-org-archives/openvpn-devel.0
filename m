From: Heiko Hund <heiko@...2662...>
Date: Wed, 07 Sep 2022 16:18:17 +0200
Message-ID: <2672591.mvXUDI8C0e@...2664...>
In-Reply-To: <20220824110930.73009-1-arne@...1227...>
References: <20210125125628.30364-11-arne@...1227...>
 <20220824110930.73009-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v5] Implement --client-crresponse script
 options and plugin interface
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

On Mittwoch, 24. August 2022 13:09:30 CEST Arne Schwabe wrote:
> This is allows scripts and pluginsto parse/react to a CR_RESPONSE message
> 
> Patch V2: doc fixes, do not put script under ENABLE_PLUGIN
> Patch V3: rebase
> Patch V4: fix else branch of the verify_crresponse_script function
> Patch V5: unify message when unable to create/write crresponse file
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Heiko Hund <heiko@...2662...>




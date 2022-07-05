From: Heiko Hund <heiko@...2662...>
Date: Tue, 05 Jul 2022 14:32:42 +0200
Message-ID: <4973410.uatBhfvki3@...2664...>
In-Reply-To: <20220624083809.23487-9-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-9-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 08/25] dco: allow user to disable it at
 runtime
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

On Freitag, 24. Juni 2022 10:37:52 CEST Antonio Quartulli wrote:
> +    else if (streq(p[0], "disable-dco") || streq(p[0], "dco-disable"))

Don't think we need to be backwards compatible here, or do we?





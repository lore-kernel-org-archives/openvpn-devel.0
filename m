From: Heiko Hund <heiko@...2662...>
Date: Tue, 05 Jul 2022 14:31:42 +0200
Message-ID: <8853519.62QXDd5JXf@...2664...>
In-Reply-To: <20220624083809.23487-19-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-19-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 18/25] dco: turn supported ciphers list
 into a function
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

On Freitag, 24. Juni 2022 10:38:02 CEST Antonio Quartulli wrote:
> Other platforms may need more complex logic to decide whether a cipher
> is supported or not, therefore turn hardcoded list into a function that
> can be implemented by each platform independently.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>
> Signed-off-by: Antonio Quartulli <a@...2181...>

Trivial and compile-checked.

Acked-by: Heiko Hund <heiko@...2662...>




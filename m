Date: Wed, 16 Mar 2022 10:29:37 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1592362800.422327.1647422977914@...2642...>
In-Reply-To: <202203160839.22G8dfkY031659@...2054...>
References: <20220316080912.118-1-lstipakov@...277...>
 <202203160839.22G8dfkY031659@...2054...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH applied] Re: vcpkg-ports: add openssl
 1.1.1n
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net



> Gert Doering <gert@...1296...> hat am 16.03.2022 09:39 geschrieben:
> 
>  
> Acked-by: Gert Doering <gert@...1296...>
> 
> As discussed on IRC, we need to build with the new security-fixed 1.1.1n
> release, and vcpkg port is not there yet.  Somewhat annoying, we should 
> find a better way to decouple "build" and "openvpn main repo" commits...

We could always move the whole contrib/vcpkg-ports directory to a separate
repository, right? Or is there a strong technical reason why this should be
in the main repository?

Regards,
--
Frank Lichtenheld


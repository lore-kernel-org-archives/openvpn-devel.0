Date: Wed, 16 Mar 2022 18:22:54 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1814938197.9888.1647451374712@...2642...>
In-Reply-To: <20220316135411.217-1-lstipakov@...277...>
References: <20220316135411.217-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH master+release/2.5]
 vcpkg-ports\pkcs11-helper: shorten patch filename
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>



> Lev Stipakov <lstipakov@...277...> hat am 16.03.2022 14:54 geschrieben:
> 
>  
> From: Lev Stipakov <lev@...515...>
> 
> "make dist" uses tar which breaks on long filenames:

I think this should specfically mention "uses tar -o". Most modern usages of tar do not have this limit.

Regards,
--
Frank Lichtenheld


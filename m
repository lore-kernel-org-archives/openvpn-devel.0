Message-ID: <4E0C3D87.6050407@...68...>
Date: Thu, 30 Jun 2011 11:10:31 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1309335848-14414-1-git-send-email-samuli@...515...>
	<1309420750-26524-1-git-send-email-samuli@...515...>
In-Reply-To: <1309420750-26524-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fixes to easy-rsa/2.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Am 30.06.2011 09:59, schrieb samuli@...515...:
> From: Samuli Seppänen <samuli@...515...>
> 
> As support for OpenSSL 1.0.0 requires a modified openssl.cnf file, it was
> decided to rename openssl.cnf to openssl-1.0.0.cnf for clarity and better
> support of different OpenSSL versions. The old openssl.cnf was renamed as
> openssl-0.9.8.cnf.

But: Whence the need to keep support for 0.9.6?


Message-ID: <43B2DD4D.7090409@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Symmetric key management
References: <BAY18-F20056B1620A7EAF32C5375A94A0@...512...> <Pine.LNX.4.60.0512261106110.23508@...495...>
In-Reply-To: <Pine.LNX.4.60.0512261106110.23508@...495...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Dec 28 10:46:08 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Nisha P Kurur <nisha@...494...>
Cc: openvpn-devel@lists.sourceforge.net

Nisha P Kurur wrote:

> How does openvpn do symmetric key management?
> We want to know specifically as to how to change the symmetric key 
> periodically. Also does openvpn support both manual and automatic key 
> management? 

Symmetric keys must be pre-shared via a pre-existing secure channel.  
OpenVPN doesn't manage them.

Most people use TLS mode rather than static key mode (using symmetric 
keys) because it handles cipher/MAC key management and renegotiation 
automatically.

James



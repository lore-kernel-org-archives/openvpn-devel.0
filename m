Message-ID: <496C52A3.2080006@...349...>
Date: Tue, 13 Jan 2009 08:36:51 +0000
From: Thomas NOEL <thomas.noel@...349...>
MIME-Version: 1.0
References: <496B7A61.6090602@...260...>	
	<9e0cf0bf0901120958n4ea62c57s991e8a6e0335fbbd@...278...>	
	<496B97F9.1020504@...349...>
	<9e0cf0bf0901122313r82c88d0u91d8a21dc99c3113@...278...>
In-Reply-To: <9e0cf0bf0901122313r82c88d0u91d8a21dc99c3113@...278...>
Subject: Re: [Openvpn-devel] [patch] enhance tls-verify possibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Cc: openvpn-devel@lists.sourceforge.net

Alon Bar-Lev a écrit :
> I think all the above can be implemented as logic into OCSP responder...
> OpenVPN needs a standard way to forward the certificate.
> Standard == OCSP

It's not easy to configure an OCSP responder with a specific logic...

> If a simple script based OCSP is out there, then all you need is solved.

All I need is solved with the patch of Mathieu : in the tls-verify 
script, I can check a OCSP responder, if it does not respond try
another, if none respond check deltaCRL+CRL... I can even send a mail in
case of a detected intrusion ;)

That's why I prefer a "general script for tls verification" instead of
just an OCSP verification.

But in fact, both patches (OCSP-system and script-system) are
complementary. CRL (current system) and OCSP can resolve a lot of
situations, script-system can resolve all others... Such an
extended verification system would be a nice feature of openvpn
(I could say : another "killer-feature" ? ;) )

Cheers,
-- 
Thomas NOEL <thomas.noel@...349...> http://www.auf.org/
Coordinateur des infrastructures techniques
Administration des ressources informatiques
Agence universitaire de la Francophonie (AUF)


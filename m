From: Gervasio Bernal <gervasiobernal@...447...>
Message-ID: <loom.20050903T161843-258@...171...>
References: <loom.20050902T143928-990@...171...> <m364tijlep.fsf@...409...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: OpenVPN Protocol
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
Date: Sat Sep  3 07:31:02 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Lars Gullik Bjønnes <larsbj <at> gullik.net> writes:

> 
> Gervasio Bernal <gervasiobernal <at> speedy.com.ar> writes:
> 
> | First of all, I will explain what we are trying to develop. Basically, our 
idea 
> | is to make OpenVPN works at kernel level, not at user level, and use the 
linux 
> | cryptoapi instead of openssl.
> 
> Just a question.
> 
> Why do you want to do this? Performance or something else?
> 
> To me running in userspace is one of the really good things about
> OpenVPN.
> 

You are right!, running in userspace is a great thing because it facilitates the 
portability, but you lose performance. Obviously, if we run it at kernel level 
we will lose that portability, but we will win performance.

Gervasio Bernal from Mendoza - Argentina
Pedro Deis from Mendoza - Argentina






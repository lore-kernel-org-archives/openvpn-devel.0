From: Ondra Medek <ondrejm@...522...>
Subject: Re: [Openvpn-devel] AW: Re: [Openvpn-devel] PKCS#11 and easy-rsa
Message-ID: <20060103121741.GA18916@...522...>
References: <6be76a4c79dcd0c0359583a8b0d1f44c@...527...>
Mime-Version: 1.0
In-Reply-To: <6be76a4c79dcd0c0359583a8b0d1f44c@...527...>
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
Date: Tue Jan  3 04:18:14 2006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Cc: openvpn-devel@lists.sourceforge.net

Hi,

> >> I've made easy-rsa 2.0 support for PKCS#11 (it makes a certificate from a
> >> token). If you are interested, then it is at
> >> 
> > In my view it lacks the following features:
> > 1. Allow the user to specify his own PKCS#11 library.
> > 2. Generate a new key.
> 
> This is wide outside of the OpenVPN usage.
> Is is to be implemented in an PKCS#11 (key) managemement tool
> but NOT in an VPN daemon.
> 
> > 3. Load the X.509 certificate into the token.
> 
> And this too has nonthing to do with the functionality of an
> VPN daemon.
> 
> Please:
> KISS. 
> Keep It Simple and Save.
> 
> OpenVPN is a small tool to do VPN tunneling.
> Stuffing not related functionality that seems fancy into it
> leads to bloatware.

Honestly to say, I have the same opinion, but Alon Bar-Lev proposed 2. and
3.3. I am not involved in OpenVPN project, but I'd like to help. So I you
decide what you need I can try to do it.


Cheers
       Ondra



From: Ondra Medek <ondrejm@...522...>
Subject: Re: [Openvpn-devel] PKCS#11 and easy-rsa
Message-ID: <20051230172613.GB6291@...522...>
References: <20051230134820.GB18626@...522...> <43B54FC3.1080907@...277...>
Mime-Version: 1.0
In-Reply-To: <43B54FC3.1080907@...277...>
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
Date: Fri Dec 30 09:27:07 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,


> In my view it lacks the following features:
> 1. Allow the user to specify his own PKCS#11 library.
> 2. Generate a new key.
> 3. Load the X.509 certificate into the token.
> 
> Now when I think of it, issue#1 can be solved by a symbolic 
> link, you can have the configuration point to a local 
> symbolic link that is linked by the script to the requested 
> provider.

maybe LD_PRELOAD is another possibility ...

> And when I look at the new version of opensc (0.10.0) I see 
> that they improved their pkcs11-tool significantly, so that 
> maybe it can be used to generate keys and import certificate 
> for every provider now.
> 
> Are you willing to adjust your implementation and fix these 
> issues? I will do it when I have some free time.


Yes, I already use pkcs11-tool for issue#2 and #3. I can try to do it.


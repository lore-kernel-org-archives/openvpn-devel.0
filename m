Message-ID: <416E4D5E.3040909@...289...>
From: Vlada Macek <tuttle@...289...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] PATCH[2/2]: Use certificates from MS Cert Store
 with CryptoAPI
References: <416D3018.4040704@...292...> <416D3C1D.6000403@...255...> <Pine.LNX.4.58.0410131057240.20018@...269...> <416D8561.3070900@...292...>
In-Reply-To: <416D8561.3070900@...292...>
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
Date: Thu Oct 14 03:01:13 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Peter 'Luna' Runestig wrote:

>  I don't know. I spent a couple of hours, trying to work around
>  MinGW's limitations when it comes to CryptoAPI, but I just ended up
>  in dead ends.

Just a thought: Maybe this addon can be made as a dynamic plug-in. That 
way both could be compiled in two different compilers and there is no 
need to port the code for MinGW. The downside of such approach would be 
that James will not probably support it.

But if it wont change often, it can be shipped as a 3rd party DLL or 
.so... Maybe in the future there will be some more opportunities to do 
it this way...

\/.



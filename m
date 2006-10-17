From: Andrew Wenlang Zhu <azhu@...716...>
In-Reply-To: <45346CD6.6090603@...744...>
References: <45346CD6.6090603@...744...>
Date: Tue, 17 Oct 2006 12:40:00 -0700
Message-Id: <1161114000.27168.131.camel@...822...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] Question about IV size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Jason Wittlin-Cohen <jasonwc@...744...>
Cc: openvpn-devel@lists.sourceforge.net

Jason,

IV size is cipher-dependent, and it usually equals to cipher's block
size, e.g DES is 64 bit block and AES is 128 bits block.

Both AES-128-CBC and AES-256-CBC use 128 bits IV. Original AES can
support various block size in its submission to competition to standard
cipher, but it only supports fixed 128 bits block size when AES is
finalized. 

Andrew


On Tue, 2006-10-17 at 01:40 -0400, Jason Wittlin-Cohen wrote:
> I was reading the OpenVPN security overview which states that an
> Explicit IV is used to ensure that two packets with the same plaintext
> do not encrypt to the same ciphertext. However, the Overview did not
> state the size of the Initialization Vector. I found this page
> (http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn/ssl.h)
> which states that "           
>                               
> 
> Ciphertext IV (size is cipher-dependent, if not disabled by
>  *       --no-iv).
> 
> 
> So, does the IV size depend only on the cipher used or does it also
> depend on the key size? For example would AES-128-CBC and AES-256-CBC
> use the same IV size?
> 
> Also, the Security Overview stated that the Initialization Vector was
> created using a pseudo-random number generator, and that each IV is
> randomized. If this is the case, what is to prevent IV collisions? Is
> anything done to prevent an IV being used twice with the same encryption
> key or is the IV of a sufficient size that the likelihood of this
> occurring is nominal?
> 
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________ Openvpn-devel mailing list Openvpn-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/openvpn-devel


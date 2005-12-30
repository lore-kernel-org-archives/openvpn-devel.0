Message-ID: <43B54FC3.1080907@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] PKCS#11 and easy-rsa
References: <20051230134820.GB18626@...522...>
In-Reply-To: <20051230134820.GB18626@...522...>
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
Date: Fri Dec 30 07:21:08 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Ondra Medek <ondrejm@...522...>
Cc: openvpn-devel@lists.sourceforge.net

Ondra Medek wrote:
> Hi,
> 
> I've made easy-rsa 2.0 support for PKCS#11 (it makes a certificate from a
> token). If you are interested, then it is at
> 

Hello,

Thank you for your patch.

In my view it lacks the following features:
1. Allow the user to specify his own PKCS#11 library.
2. Generate a new key.
3. Load the X.509 certificate into the token.

I though of implementing a similar interface but the lack of 
ability to supply engine-pre from openssl command line, and 
the lack of standard tool to generate keys and import a 
certificate, made me drop the issue.

Now when I think of it, issue#1 can be solved by a symbolic 
link, you can have the configuration point to a local 
symbolic link that is linked by the script to the requested 
provider.

And when I look at the new version of opensc (0.10.0) I see 
that they improved their pkcs11-tool significantly, so that 
maybe it can be used to generate keys and import certificate 
for every provider now.

Are you willing to adjust your implementation and fix these 
issues? I will do it when I have some free time.

Best Regards,
Alon Bar-Lev.


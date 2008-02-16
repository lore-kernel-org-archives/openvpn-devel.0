Message-ID: <4aff28800802160916r506572a0r44a9e619e31ce5ee@...278...>
Date: Sat, 16 Feb 2008 19:16:29 +0200
From: "Diaa Sami" <diaasami@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Compiling OpenVPN 2.1rc7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,
I was compiling OpenVPN 2.1rc7 on Windows(MinGW) and I did it
successfully after 2 days of trying.
This is a list of the issues I met, I thought I should tell you so
that you can fix or mention them at least to make building easier:
* The current latest version of PKCS11-helper(which is 1.05) doesn't
produce a DLL when compiled using MinGW, although the DLL is needed
for building OpenVPN successfully, (I just used the DLL from the
binary distribution so that the build will succeed without having to
modify the installer)
* In the compilation command, although PKCS-helper depends on OpenSSL,
it comes after it in the libraries(I had to fix this by modifying the
makefile)
* After compiling OpenSSL 0.9.7m, it's necessary to copy all files
matching incout\openssl\* to include\openssl\*
* The source tree must reside under the same drive as WINDDK(which is
hardcoded as C:\)

Regards,
Diaa Sami


Message-Id: <72D655DC-4EF6-47E8-B6DD-8800E102A0E2@...1348...>
From: Toby Thain <toby@...1348...>
In-Reply-To: <C5DC4FDD-13FA-45AC-9D17-35BE15E03C1D@...1360...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Sat, 1 May 2010 16:56:16 +1000
References: <B23F897A-5ADC-4A29-A34B-3BB16C18B4F3@...1360...>
	<4BD7DB78.2010704@...1114...>
	<C5DC4FDD-13FA-45AC-9D17-35BE15E03C1D@...1360...>
Subject: Re: [Openvpn-devel] [PATCH] Mac OSX Keychain certificate support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Brian Raderman <brian@...1360...>
Cc: openvpn-devel@lists.sourceforge.net


On 1-May-10, at 4:18 PM, Brian Raderman wrote:

> Hi David,
> ...
> * Removed the dummy1() function from keychain.c.  Keychain.c/.h are  
> based on cryptoapi.c/.h in the openvpn source tree.  When editing  
> the original file to work with the Keychain services libraries  
> instead of the Windows Crypto API, I decided to change as little as  
> possible, the theory being that what was there was approved and  
> accepted.  You will see a static dummy() function defined at the  
> bottom of that file as well.  I had no idea what it was there for,  
> but I figured there was a reason for it so I left it alone.  I think  
> I tacked on the 1 to the end without thinking too hard because I was  
> being very defensive and trying to prevent a scope problem, which  
> was silly of me because the function is static and you would never  
> compile Windows-only and Mac-only code at the same time.  If you  
> grep for "dummy" in the source tree, you will see a number of places  
> where this paradigm is used.  Perhaps because some compilers will  
> not compile a file that has had all of its code ifdef'd out?

 From a recent patch to Maria (database), I believe this may be the  
case on Windows, for example:

+#elif defined(__WIN__)
+
+// Remove linker warning 4221 about empty file
+namespace { char dummy; };
+
#endif

I can't fully confirm this right now as I am away from my Linux/WINE  
environment that runs the MS Visual C++ Express toolchain.

--Toby


>  I tested this theory on my mac and no error occurred, so I went  
> ahead and removed the function per your request.  I should also  
> point out that cryptoapi.c makes calls to calloc, which you may want  
> to change at some point if you are trying to standardize on the  
> gc_arena API.
>
> Please let me know if you have any questions or if more changes are  
> required.
>
> Thanks,
> Brian Raderman



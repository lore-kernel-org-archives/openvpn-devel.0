Message-Id: <200302060512.h165CCf25581@...41...>
Subject: Re: [Openvpn-devel] Trimmed down permissions for generated keys
From: "James Yonan" <jim@...41...>
In-Reply-To: <20030205084559.GA3451@...30...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Feb  5 21:13:03 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...64...>, openvpn-devel@lists.sourceforge.net

Hi Alberto,

Yes, I agree.  The owner-execute permission is unnecessary.  I will add patch
to next release.

James

Alberto Gonzalez Iniesta <agi@...64...> said:

> Hi James et al!
> 
> Intro
> -----
> openvpn creates pre-shared secret files, for latter use in static key
> encryption mode (non-TLS), with the --genkey option
> 
> The minor/anecdotal glitch
> --------------------------
> 
> The permissions for the created file may be/seem to be excessive (0700)
> Pointed out by Herbert Xu <herbert@...65...> [1]
> 
> The patch
> ---------
> 
> --- openvpn-1.3.2.orig/crypto.c
> +++ openvpn-1.3.2/crypto.c
> @@ -968,7 +968,7 @@
>    struct buffer out = alloc_buf_gc (512);
> 
>    /* open key file */
> -  fd = open (filename, O_CREAT | O_TRUNC | O_WRONLY, S_IRWXU);
> +  fd = open (filename, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR);
>    if (fd == -1)
>      msg (M_ERR, "Cannot open shared secret file %s for write", filename);
> 
> 
> Let me know if you like it/agree, James. Thanks,
> 
> Alberto
> 
> 
> 
> [1] http://bugs.debian.org/178849
> 
> (PS. I resent this mail, since I first sent it from the wrong address,
> sorry James)
> -- 
> Alberto Gonzalez Iniesta       | They that give up essential liberty
> agi@(agi.as|debian.org)        | to obtain a little temporary safety
> Encrypted mail preferred       | deserve neither liberty nor safety.
> 
> Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 





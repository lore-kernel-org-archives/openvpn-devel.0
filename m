Message-ID: <20110414215241.16185.qmail@...1287...>
Date: Thu, 14 Apr 2011 23:52:41 +0200
From: Peter Stuge <peter@...1287...>
References: <1302791399-23728-1-git-send-email-davids@...1347...>
	<1302791399-23728-2-git-send-email-davids@...1347...>
MIME-Version: 1.0
In-Reply-To: <1302791399-23728-2-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH v2] Change the default --tmp-dir path	to
	a more suitable path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

David Sommerseth wrote:
> In commit 4e1cc5f6dda22e9 the create_temp_filename() function was
> reviewed and hardened, which in the end renamed this function to
> create_temp_file() in commit 495e3cec5d156.
> 
> With these changes it became more evident that OpenVPN needs a directory
> where it can create temporary files.  The create_temp_file() will create
> such files f.ex. if --client-connect or --plugin which makes use of
> the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY hook, such as openvpn-auth-pam.so.
> 
> When this happens, OpenVPN will normally create these files in the directory
> OpenVPN was started.  In many cases, this will fail due to restricted access.
> By using --tmp-dir and pointing it to a directory writeable to the user
> running OpenVPN, it works again.
> 
> This patch makes OpenVPN use a more suitable temproary directory by default,
> instead of the current working directory.  On non-Windows platforms this
> default value is set to '/tmp', but can be modified at compile-time by
> running ./configure --with-tmp-dir-path=<TEMP DIR PATH>.  On Windows, it
> will use GetTempPath() to find temporary paths recommended by the OS.  If
> this fails, it will fallback to the old behaviour, using the directory
> where OpenVPN was started.
> 
> In any cases, this default value can be overridden in the configuration
> file by using the --tmp-dir option, as before.
> 
> To check what the default is at runime, you can see this easily by doing
> this:
> 
>       $ ./openvpn --verb 4 --dev tun | grep tmp_dir
> 
> Signed-off-by: David Sommerseth <davids@...1347...>
> Tested-by: Jan Just Keijser <janjust@...1147...>

The above commit message doesn't really fit the patch anymore. :)


> diff --git a/options.c b/options.c
> index 36e8393..7303cb4 100644
> --- a/options.c
> +++ b/options.c
> @@ -766,11 +766,23 @@ init_options (struct options *o, const bool init_gc)
>  #ifdef ENABLE_X509ALTUSERNAME
>    o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
>  #endif
> -#endif
> -#endif
> +#endif /* USE_SSL */
> +#endif /* USE_CRYPTO */
>  #ifdef ENABLE_PKCS11
>    o->pkcs11_pin_cache_period = -1;
>  #endif			/* ENABLE_PKCS11 */

The above hunk is not really related, right? Looks fine otherwise!


//Peter


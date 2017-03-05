References: <79d89580db6fd92c059dabc4f5f4d83b72bb9d3d.1487859361.git.logout@...260...>
	<201703050953.v259rZMs067447@...2054...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3af72d9f-1d38-f9c7-8ebd-3ac16baa09c4@...1856...>
Date: Sun, 5 Mar 2017 11:29:01 +0100
MIME-Version: 1.0
In-Reply-To: <201703050953.v259rZMs067447@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: OpenSSL: don't use direct
 access to the internal of RSA_METHOD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


On 05-03-17 10:53, Gert Doering wrote:
> Small side note: I assume that RSA_meth_new() can fail and return NULL
> in OpenSSL 1.1?  Because for 1.0, the "check_malloc_return(rsa_meth)" call 
> isn't necessary, as ALLOC_OBJ_CLEAR() would call ALLOC_OBJ() and that
> already checks...  (mentioning this here in case someone wonders and goes
> to the list archives).

For the archives: yes, RSA_meth_new() indeed returns NULL if it's
internal malloc() call fails.

-Steffan


Message-ID: <4C6BD3E9.6060909@...68...>
Date: Wed, 18 Aug 2010 14:36:57 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1282134451-21285-1-git-send-email-dazo@...384...>
In-Reply-To: <1282134451-21285-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] Test framework improvment - Do not FAIL
 if	t_client.rc is missing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 18.08.2010 14:27, schrieb David Sommerseth:
> This is to avoid 'make check' fail if this extra test case is not
> configured.  The patch gives a PASS, but will notify the user that
> this test was skipped.

The other question is how t_client.rc can go missing...

-- 
Matthias Andree


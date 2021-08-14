def plot_cf(x, n=1000, m=100, prec=53):
    """
    plot continued fraction info of `x`
    """
    cf = continued_fraction(x)

    pAn = line([(i, cf[i].n(prec)) for i in range(n)], title=r"$ a_n $")

    ptsProd = [cf[i] for i in range(1, m+1)]
    for i in range(1, m):
        ptsProd[i] *= ptsProd[i-1]
    pGeomAvgAn = line([(i, (ptsProd[i-1] ** (1/i)))
                      for i in range(1, m+1)], title=r"$ (a_1\cdots a_n)^{1/n} $")
    pQn = line([(i, cf.q(i).n(prec)) for i in range(m)], title=r"$ q_n $")
    pLogQn = line([(i, log(cf.q(i)).n(prec))
                  for i in range(n)], title=r"$ \log\,q_n $")
    pAlpha2Conv = line([(i, abs((x-cf.convergent(i)).n(prec)))
                       for i in range(m)], title=r"$| \alpha - p_n / q_n |$")
    pLogAlpha2Conv = line([(i, log(abs((x-cf.convergent(i)).n(10*prec))))
                          for i in range(m)], title=r"$ \log\,|\alpha - p_n / q_n |$")

    return graphics_array(((pAn, pQn, pAlpha2Conv), (pGeomAvgAn, pLogQn, pLogAlpha2Conv)))


def save_cf(x, f, pngDpi=500):
    "save plot of continued_fraction info of `x`"
    plot_cf(x).save(f, dpi=pngDpi)


tribonacci = solve(x ^ 3 - x ^ 2 - x - 1 == 0, x)[-1].rhs()
quabonacci = solve(x ^ 4 - x ^ 3 - x ^ 2 - x - 1 == 0, x)[-1].rhs()

import logging

logger = logging
logger.basicConfig(level=logging.INFO,
                   format='%(asctime)s: %(levelname)s [%(filename)s:%(lineno)s] %(message)s',
                   datefmt='%Y%m%d-%I%M%S-%p',
                   handlers=[
                    #    logging.FileHandler(__file__+'.log'),
                       logging.FileHandler(__file__+'.log'),
                    #    log en la terminal
                       logging.StreamHandler()
                   ])

# if __name__ == '__main__':
